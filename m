Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB06D29DE0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYh0-0000gF-NQ; Tue, 13 Jan 2026 02:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYgz-0000eR-8x
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYgx-0005VR-PZ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768288790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5BJoubIZ490sFIiPznhI6p1rTu5MdWOWHWBlUhBsX8w=;
 b=CAzxxIf0RlsTknxHTCIbcuvdqWxxFR7Ukxjqf0rY1e5rb7VyjFYehimFK4vGY6IfcVnpuW
 PPoVa/Oy+hW+KqAvRGdnQulzP0lCqt75J8JK3KjAhGT6Pn5KIrO+xJPMk/u83uJJ6ZeniZ
 QCrZn6mrC12wG2PP1rs2qNpSWtx5dIM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-iONRQFBpMhaddllqTKKmEg-1; Tue, 13 Jan 2026 02:19:48 -0500
X-MC-Unique: iONRQFBpMhaddllqTKKmEg-1
X-Mimecast-MFC-AGG-ID: iONRQFBpMhaddllqTKKmEg_1768288787
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-64db7bc9921so12358844a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768288787; x=1768893587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5BJoubIZ490sFIiPznhI6p1rTu5MdWOWHWBlUhBsX8w=;
 b=oMbJU6SycxbZQkdh0sfNn5q9aIXWiHE6NInIcJp4QqvL25LEo7oB4vJu3BgqVrOeG5
 M4UaUo7I+sQ2oMTivRBvbZ7yNajuaJ/sEr0BJqLeTeWk+PJbzz6hZrQZqVuvkpMiLF+R
 A7CtuRHq0RtTIc8t51p7Dq3wU5smyaNQStZbA+8/r/WUacyaKndBMykYj3Z+rN6y8Wza
 DiNTKwsvochbZ50br59/CW5MR+IAZqRTdlY6X64FFrv9h1T66E4P5JlfXsH/swxeC/iD
 rutMnfjTMZ1xFjnAUcpNEgmgrYxg8Sg423YcPhq5R2aK2y0NsWSYkihtlaHM9fJ/M7zS
 peQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768288787; x=1768893587;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BJoubIZ490sFIiPznhI6p1rTu5MdWOWHWBlUhBsX8w=;
 b=V8ODhkUh52DF3qrPhLnowAJeam8hdhKAAQav/VbNAoNhX2SeqV3WfXWxcSP91Q2s9O
 mzpFmKkSKWIXgjhGLcHHKVSh4mPv4bBF0qaHByvOtBQyFDhpKaVFbKqnzT+S39F20QLx
 hFbxLnKOhSXcU2TQX7Iz6KpuIBxBPaoKp1RaGq6GVI7co2iaBibN65MhP9rnM2JoZUGE
 besBZJ6sxo+8F0nlu2LFlw8vADF2osDcLT6rpKn0vP4E7ajT3Nb7U30Kip1Y7sFC9KE8
 VTFESnng4Hb8y66wenclL1rZn2d0KWjmtDlHBcA5w/4eAXrR6VTvf8KnvtRjton8h7Ys
 0AgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBoL60tGOzcaaT8onRxUATnI6VZGW5lmBwc75KknJID0pRpud0LOBGsZK889BWUDmDfVRC2RYCwAeI@nongnu.org
X-Gm-Message-State: AOJu0YzH4RLdF3DG5xwq/+VBNcatPeihXVTkrmRFh5n+b54nEpeo1z/p
 /dA/rIz9DBZkT1ueBD7by64jZYtngdahHKIyanag/SjjduscEUpKewYgV4Ql/fl3MoDNjFuB97B
 vytjoCop92NsOf9B67YZZ13UqF4WGqpyuRqQTNS9T8tlydjGLmQOhOT6LwpWOxWZ4
X-Gm-Gg: AY/fxX7YSgkyX71grcdyi9+vACPrPCvYBUjbcAMMqg4pgR+Y5f/haXhzqges5TY0O1l
 LzP/wi+IJRrZ8cVXsvW+L/mmcVZSIwr0/KCTkPsSrHhlxVbWzKAQN+7HeIc2I4SXENCDAVqvMAl
 hTcJRaXweEcuupn28Sz8h/gPsyqMaFUP2WmXBAbpvzqXECbTJ2BbWhQviXN5sptgAS0vBuZlIip
 0s6hJsIcwTcn0gqdGiRRrnfCihN6FsDQgNR8eTdakrUMLz7/Jbt5oYccGzcV8VWM65oMjarqH77
 FkWHtJ4wwvSBc/10x7Q++HzgzucI1t1cSPcVMFyTeAqhPduSQICdTO0lpT2onLZXptLcEov9WSg
 lX3xHMBE=
X-Received: by 2002:a17:907:a03:b0:b77:1d75:8b78 with SMTP id
 a640c23a62f3a-b84453cafb8mr1810049166b.53.1768288787231; 
 Mon, 12 Jan 2026 23:19:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH44zPX/rwNu7xN6X8BFJ1Eu1V5lefbDnzovPfSBkUIKYbWE/86tQqxHIslsJ6Htv6k5J4P+A==
X-Received: by 2002:a17:907:a03:b0:b77:1d75:8b78 with SMTP id
 a640c23a62f3a-b84453cafb8mr1810047366b.53.1768288786821; 
 Mon, 12 Jan 2026 23:19:46 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86ebfd007fsm957022566b.31.2026.01.12.23.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:19:46 -0800 (PST)
Message-ID: <34c25745-403b-4d3d-b9e6-ab671534d185@redhat.com>
Date: Tue, 13 Jan 2026 08:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] tests: print reason when I/O test is skipped in
 TAP mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-3-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> The TAP output on a skipped test:
> 
>    ok raw 181 # SKIP
> 
> is not informative.
> 
> The test program included a reason, and that should be displayed
> in TAP mode (it is already shown in non-TAP mode):
> 
>    ok raw 181 # SKIP Postcopy is not supported
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/testrunner.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


