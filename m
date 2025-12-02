Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80406CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 07:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQLER-000776-Jc; Tue, 02 Dec 2025 02:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQLEO-00074z-N2
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQLEN-0001W0-Az
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764662125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YXN3Te3mFx1PldSDydyZ0s/NgvKX67rmewGiirt/xG0=;
 b=d0cqjxqKJu5DUEysWyvrp1jiw6N9j/LcizIz+qhd96k1LEsIp3DH20cJDVTqbJQlVY7yBK
 4EMBUu12jG0P5LMnathfdqa4Ev+aqYJD+DfOoKp3n26P6FLNUy8nSWJHvsC6ZOzzIpH544
 WMZAm9EcY3WlzMUl0c+PQG06qw7t9Ug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-xDKC0YBJOByjFhxabDeDhQ-1; Tue, 02 Dec 2025 02:55:24 -0500
X-MC-Unique: xDKC0YBJOByjFhxabDeDhQ-1
X-Mimecast-MFC-AGG-ID: xDKC0YBJOByjFhxabDeDhQ_1764662123
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b70b1778687so342105866b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 23:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764662123; x=1765266923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YXN3Te3mFx1PldSDydyZ0s/NgvKX67rmewGiirt/xG0=;
 b=K85fDoXpK8qRoyufKsr2lO1QT+aAC4Dw5+j+3n2B4qjMUGoe6u1RDI+q8sA5vJlVDN
 oSOFxmILs+5BZzAqbhW924Ed35XqcaTsZbL1w/XZqZGAuPk5U2a/BOnO9lpQCwj/rTqk
 8g2wAE5dzwwH6Ko8plJJXoo+5nRZKeAo9E7qUaYbLxtLqieQlzEA49iOnET3apn6EgBF
 SUCFdXV4spB+1+Bqe6ApLMCsoswgT4DN174kq5WXZqV+58a8BSCZ01gfjipxmU7eq95S
 vBdC6cZmxCKjX+TXIvXKmlrkkfCLGazIt4OoVjlFC64moupuPWwqBD4Ylo6Rz4O5vxIn
 7ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764662123; x=1765266923;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXN3Te3mFx1PldSDydyZ0s/NgvKX67rmewGiirt/xG0=;
 b=p7TsyxAE3RoyUC9zmfUzpzbZdUbo3M1zZVw4Ndlwv+OwVZWkEnDzn0QB7nC75r1q/6
 i+5jcOm3mv9Mc2M/fsUSk6eP/cR3LPO2U2o1+IljQUIdm88ioVg3Z3+vtF1C1vo/0Qru
 KeeuMWVp1pl+aWu5Z+Iva+ZCKZ7PreOzejHxazb3IFA+5Jl3f03ESTvdS0SROig3FRzt
 483YIXjZCXEARE+/Gbnw6Ka1FBbJsVz+QulkuYImbRr0HtNGHePsueQto73JjJnCYO9s
 /nvQvJXJ0n4Ed0w/MtzANA+gOLhLPe8da+Kzb8SM/yLhDlNGoom641GbOsZvOA2+jWfO
 PW4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0denCMR8fLyd+8AkreUgZZW+3ZhluieXoRadnbuo1oCrQLqpcm5Fs5M5EFqUPwl11WWiS6lxk3JoX@nongnu.org
X-Gm-Message-State: AOJu0Yx5YZmCjlRHPzImqVArTJ/mRHRq7fTCinkEE/brOHTI7VEgecL3
 ZrReuivHBs4S42n/DYuzvAlMMYkWqucF2OhSSM4f9hnl53EDG/Xhc5UwuaWXiTwDoISIkuTki57
 xSYKHRtLQmmrv60ijDyeW+l1YXeJCkkwNQZ/g9yPxE9iCgwi1EEpGpme+
X-Gm-Gg: ASbGncvd7fwa501e/vuJCHj+pNbDcjEGKPUKUl0X5WkrvLufpz/9jb8POzHoSyTWfSl
 qRbYtiGA9/l9dRxlqi4c6Aa0s0fqQZE131r6oGA/XqXUoUF+s7cBUaMRvaDhAfyrTxa4udsscSW
 HgxWbGtS6ZvqC+NFf7Eg1150ULQbQ9iXwL+DHiNIdbKEPYXa77neiWlaaMErdbqUO5chBPNhcOv
 XAq712v5w1kuTP7q8BzS0ofuJjXZwLjvRNM10f7CFOCjlBAd8mObobqtlnqEBkAN9lId9DfL/0J
 QLyUAdq3uZwSlzF4Zrd8P/oRPIWPtcIy5Q3gr5Gzhko11BhtOc+A+u8KjvnSuUphp5TmzT+d6r0
 MR14JSI+MKq8boMewUY7VY4pJKAIaeyfJYUUYYw93RRQRuxhgz3f7B6hcEwpKX8+JsloNCyM9hA
 Ory6VsPIhhI7oAJMM=
X-Received: by 2002:a17:906:fe4c:b0:b76:694a:b0ca with SMTP id
 a640c23a62f3a-b76715ebba8mr4508178866b.27.1764662122715; 
 Mon, 01 Dec 2025 23:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2A2qqjZ+l90yqLY4gp2BfCbaltcrK1MZSN0wXjCoGExm9+Wgf2cotGQRLsGQ5mPv+Zl3mSA==
X-Received: by 2002:a17:906:fe4c:b0:b76:694a:b0ca with SMTP id
 a640c23a62f3a-b76715ebba8mr4508174766b.27.1764662122264; 
 Mon, 01 Dec 2025 23:55:22 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b76f5162d49sm1433777966b.14.2025.12.01.23.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 23:55:21 -0800 (PST)
Message-ID: <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
Date: Tue, 2 Dec 2025 08:55:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/24] audio: add GStreamer backend
To: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, geoff@hostfission.com
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aS4BZZnzQPUHzbaD@vm3.arverb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/1/25 21:58, Alexandre Ratchov wrote:
> On Mon, Dec 01, 2025 at 10:20:49PM +0400, Marc-André Lureau wrote:
>>> cases. Also when using jack you'd want to have a QEMU backend for it not
>> It would be great if people with very specific or constrained requirements
>> on qemu audio could check if the GStreamer backend fits their need.
> 
> I'm thinking mainly about their simplicity.
> 
> Dropping the system API backends would add an extra sophisticated
> layer (GStreamer) between the system and the program. In theory, an
> unlimited number of software layers may be stacked in a program, but
> the more layers there are, the more fragile the program tends to
> be. Based on my limited experience, when things went wrong, the system
> backends were simpler to debug and make work than the big frameworks.
> 
> IMHO, the system API backends won't hurt GStreamer users, so I see no
> reason to remove them.

I mostly agree.  Perhaps the DirectSound backend could be removed by 
just letting Windows use SDL (unlike macOS, Windows doesn't have a 
"native" GUI layer), and the ALSA backend is also not so useful in my 
opinion.  But all the others have a reason to be there.

Paolo


