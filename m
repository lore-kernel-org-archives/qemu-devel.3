Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56317D3177F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ODz-0002jG-Qb; Tue, 05 Nov 2024 13:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8ODr-0002il-N6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8ODp-0006Ge-F8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730831047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nT6o0alT//o5rIREHqaPOaXSA4kw6GIk7ibzPprxVsI=;
 b=fWEToQ+P2W+tDgChm7/J+b+ZV0pgIbnLgaluo6Ytt+bWkfV10ZNx2ONo9WkirG5s6dza86
 Bj1YFzM+qLoGIcTq3NLo0Vxl9TuZRBu/3dWUV8mtt+K+KWtrlaBDD6RJDyNmY8QaoPug6j
 tG8jTC5u52umhBM88HaR00Jge5j8vhg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-zB2w61lkO-2wJbM6qdsavg-1; Tue, 05 Nov 2024 13:24:06 -0500
X-MC-Unique: zB2w61lkO-2wJbM6qdsavg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5eb85572083so4428588eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 10:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730831045; x=1731435845;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nT6o0alT//o5rIREHqaPOaXSA4kw6GIk7ibzPprxVsI=;
 b=dEaKMvrdL1tYNcSkgSYucm4eFgLT6CRB/ZAWNN7JYzSwQRlT4eQ9pPn2mZVNfgqVW9
 OfcJxSpVyoRmBuUCpO/aOgZeHLarN/KglfMGwHHH510DJYO8qg016+WPpdATn35R6yZB
 7KpNCY9bIKs6VJg5yO9MkNulg/++G5MrjL1BUs4ANlmtKYaYWuq07bACwx2o5ByHqrSs
 rcz15IWmRMPcT8kh3ppfNRkCKn3ktTw04qmdMHI0RQdEahfkYUTPAifI1KiCmTBypBXF
 5VH0S2JL64uwqjAlTc2JsdLCWZP4G+Gc5ITaRR0VaAMWKHtKJ7RknXonsMN2MNN2pYE4
 IJtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEh0vejgSgL6tWDoljMFeS0HF8hDxU/iDJMOOrsHpfI1yso9XgXOjRzmokm0/b1FcKU2X7kdMH9zYT@nongnu.org
X-Gm-Message-State: AOJu0YwSFYydgOtKO145tMUo18cdSCf5Y5y2k4Kl4BqkFdSTMKlD1bQO
 eGNyy3McTa1qL5xlCprFijR30HbaMQvEmY3GaNzzbf9M9n4F4JoIJXnSs3nhmB5Xp6gEkIOhL94
 tymIWxTD/aOo3DCPpBvN347ULvIm6Mhhb6JXhPwRUzNqrxTP0lahm
X-Received: by 2002:a05:6820:1c93:b0:5e7:caf5:ae03 with SMTP id
 006d021491bc7-5ede631771amr11026167eaf.2.1730831045687; 
 Tue, 05 Nov 2024 10:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZZtiiLlt0oK0VXNjSKnmQ63m74Whk5LxYeGDlhfmpHWWXioBhgqqVsX5UrTW6af2IWWi9Nw==
X-Received: by 2002:a05:6820:1c93:b0:5e7:caf5:ae03 with SMTP id
 006d021491bc7-5ede631771amr11026155eaf.2.1730831045381; 
 Tue, 05 Nov 2024 10:24:05 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec706077b9sm2306506eaf.36.2024.11.05.10.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 10:24:05 -0800 (PST)
Message-ID: <88b9cd13-a5e1-4924-a413-eedf92f7285a@redhat.com>
Date: Tue, 5 Nov 2024 19:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests: refresh package lists with latest libvirt-ci
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241105162002.359227-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241105162002.359227-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/11/2024 17.20, Daniel P. Berrangé wrote:
> This updates the libvirt-ci  submodule to pull in various fixes,
> the most notable reducing native package sets in cross builds.
> Some packages were mistakenly marked as native, rather than
> foreign, in libvirt-ci. Fixing this causes our dockerfiles to
> pick up the cross arch package instead of native one, thus
> improving our test coverage in a few areas.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 8 ++++----
>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 8 ++++----
>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 8 ++++----
>   tests/docker/dockerfiles/debian-i686-cross.docker     | 8 ++++----
>   tests/docker/dockerfiles/debian-mips64el-cross.docker | 8 ++++----
>   tests/docker/dockerfiles/debian-mipsel-cross.docker   | 8 ++++----
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 8 ++++----
>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 8 ++++----
>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 4 +---
>   tests/lcitool/libvirt-ci                              | 2 +-
>   tests/vm/generated/freebsd.json                       | 2 +-
>   12 files changed, 36 insertions(+), 38 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


