Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBD5CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsdo-0005Wh-70; Wed, 04 Sep 2024 12:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slsdl-0005WA-NE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slsdj-0001gx-TM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725466430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SdcT0PP/Z9zalNeW0GzXZ4o+/MLnZP8j0/JGBnmzBvM=;
 b=g3U+AZXsraVPRfU0vuHbR3KFvcvtIpUVG0pyFCGYRKq6osCXhQ0wYOO1s36OVqwekxKMmp
 eRi6Zo97J9hJOwmhIL8MsPwD3bjD+S4oUXHLfi2WePyiQuQHFtKMpBboTHIwQpJafaMiIt
 nrv2tBAEQJHwx1vSLl/hmMVdog/dFv4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-7rNEFv-YOniHDN0fqbR17w-1; Wed, 04 Sep 2024 12:13:48 -0400
X-MC-Unique: 7rNEFv-YOniHDN0fqbR17w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a803adfe52so130616785a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466428; x=1726071228;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdcT0PP/Z9zalNeW0GzXZ4o+/MLnZP8j0/JGBnmzBvM=;
 b=Wzez28qNP/U1mSNNXepK5dUTYCb6+PxfqxZ0DMBgpUuaY3m8PfC36ojSPmI+eBKqx6
 RhiYhDvNq3ieboL4ynHdtcpBPhm6nJOAxcgBL04H0SfFlBNCg9lFypXrvYHLoTquFXQ7
 5m32h83ZlarhxEhC8XmST+JOz4Agn7qRsyhRLtBAhple6zuNcKEIUgZctux3bpyZTh2M
 7bCFrjBzzdXiCrsCNuJloSPs9lVtKLxGznuxS03Ad3lzum8DCL5UnIMOB7lmgRne90HH
 xcgpFZXum+clv0P2qF6FcM+HCskkpr8uU6XcgyKQAVSk8vb0BYn2ZEZ0ZH9+20c1MBws
 13iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIgPT8+8R4J3gn2Y0q+2lGibTdRUXwSPrNo4kVkGys96pLSGHhmbPFi+/T+RKYITEVFHPHB66aaVKm@nongnu.org
X-Gm-Message-State: AOJu0Yz5GvHMKIqtauC/+UsXz2xHUo9qTb3Yo1577dJpwvLzzyzHqZK9
 kfrJFHDu7WuoIWwU6rMuoT6BJhszz9Zn+zcnyaRw0u9TsyUaaUN05HzqXIjs1OGD6Htlu4/MLln
 V2U5xsFjkHb+11rZN6/zom8nEQnR5tzvXax44humvGtV1Z4qTyIcv
X-Received: by 2002:a05:620a:2807:b0:7a1:d8df:c0d7 with SMTP id
 af79cd13be357-7a8041af4c3mr1825172885a.23.1725466427731; 
 Wed, 04 Sep 2024 09:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVUTkOVDBfu9eLVZRA59rzrMluwT7f2lAZr4uj4t7qe9Z2qH78ujOPUYoFWsXN9YD0oYFrtg==
X-Received: by 2002:a05:620a:2807:b0:7a1:d8df:c0d7 with SMTP id
 af79cd13be357-7a8041af4c3mr1825170185a.23.1725466427368; 
 Wed, 04 Sep 2024 09:13:47 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-181.web.vodafone.de.
 [109.43.176.181]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d390c4sm632429885a.95.2024.09.04.09.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 09:13:47 -0700 (PDT)
Message-ID: <789b890f-837e-4157-afe4-9f91c31a2083@redhat.com>
Date: Wed, 4 Sep 2024 18:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] target/cris: Remove the deprecated CRIS target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, devel@lists.libvirt.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-14-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240904143603.52934-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04/09/2024 16.36, Philippe Mathieu-Daudé wrote:
> The CRIS target is deprecated since v9.0 (commit c7bbef40234
> "docs: mark CRIS support as deprecated").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                         |    1 -
>   docs/about/deprecated.rst           |    8 -
>   docs/about/emulation.rst            |    4 -
>   docs/about/removed-features.rst     |    7 +
>   include/exec/poison.h               |    1 -
>   target/cris/cpu-param.h             |   16 -
>   target/cris/cpu-qom.h               |   32 -
>   target/cris/cpu.h                   |  286 ---
>   target/cris/crisv10-decode.h        |  112 -
>   target/cris/crisv32-decode.h        |  133 --
>   target/cris/helper.h                |   23 -
>   target/cris/mmu.h                   |   22 -
>   target/cris/opcode-cris.h           |  355 ---
>   target/cris/cpu.c                   |  323 ---
>   target/cris/gdbstub.c               |  127 --
>   target/cris/helper.c                |  287 ---
>   target/cris/machine.c               |   93 -
>   target/cris/mmu.c                   |  356 ---
>   target/cris/op_helper.c             |  580 -----
>   target/cris/translate.c             | 3252 ---------------------------
>   tests/qtest/machine-none-test.c     |    1 -
>   fpu/softfloat-specialize.c.inc      |    4 +-
>   target/cris/translate_v10.c.inc     | 1262 -----------
>   scripts/coverity-scan/COMPONENTS.md |    3 -
>   target/Kconfig                      |    1 -
>   target/cris/Kconfig                 |    2 -
>   target/cris/meson.build             |   17 -
>   target/meson.build                  |    1 -
>   tests/data/qobject/qdict.txt        |    6 -
>   29 files changed, 9 insertions(+), 7306 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


