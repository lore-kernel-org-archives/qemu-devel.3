Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AFFD12D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 07:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPJh-00081U-3R; Mon, 11 Nov 2024 02:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAPJ3-0007yw-OP
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 02:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAPIz-0007vL-PC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 02:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731311868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HQmcALrQ1guwEpfmgJ/YyXq7vCO6yNEolihfrvAqnFo=;
 b=NSxgPxK4fAAuDl/Aflr8O5p/JNXrx5i873cHFEwZmy1aRF9Cy5JdGnY/TpjI5y2gWn/BFI
 MJ9MZD33JGdtv4Ldbjx3ZInQl9gqEpDYGrrvoNZH/c2IB8D84EMoOc1Fxu+vKchCqiSB8d
 ol6BywRMs7Ag8CjM6dl41vLoBPFbvO8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-dBz2GK_0M3CxLFSnNmYEEQ-1; Mon, 11 Nov 2024 02:57:47 -0500
X-MC-Unique: dBz2GK_0M3CxLFSnNmYEEQ-1
X-Mimecast-MFC-AGG-ID: dBz2GK_0M3CxLFSnNmYEEQ
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5cbadbef8edso3660677a12.3
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 23:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731311866; x=1731916666;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQmcALrQ1guwEpfmgJ/YyXq7vCO6yNEolihfrvAqnFo=;
 b=Lehapeo5kxlrJFrrJGAAIjCuzJ+FxoTrTnSB4ZI1U3gVcsveq5tp+rUGqpPP5wytw0
 T0ZOvyn9G4PR7gvvtLCa65n6J2aBEkhJJUw9li4y7AvugZhUabBMxo9BWMir/ktrm7sM
 ZJyStB5ajxs+v19wkpTZNTF7IT0ZTzvu8hEesDMOeStnPfQacguBiNxwSGsYcBKJBjIx
 3IbUG9MtaCxybR6mMhVTSQDEVRGwG62u7I9EW0d0oR/SPMNuLVBtUduCWcCJCxItpuU4
 +ao/Ug/iHsu9t1GrWNwbFS8571Zu9MBilakV/LOgrXfZCkElN3Jn4aP15kyK0zk/W/7g
 nVrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR4zNk4baivvdjy3vzur1aAeD6e9Gm197LekLN7VRCr6ThWuc5UCNqWN30iqPwMPMvrtWqlt296kYo@nongnu.org
X-Gm-Message-State: AOJu0YxGzG8WTMib5/FdJC4GXZfJxWg906ubXfkBlHeufFlnfANcC7XK
 7sk+pw08RqnhNF5C0nHXMceyL7VV9Iuh8eZe/daauS0/HtL/KixJksp309mqr+n1SPPMWCAXPM8
 sjRvb0P7wjwgFDIcvukIpDg9vlUP9sATtLOKnhVqz+bYWpsyU4c3t
X-Received: by 2002:a05:6402:234f:b0:5ce:c9d3:9fd7 with SMTP id
 4fb4d7f45d1cf-5cf0a31b925mr9575084a12.9.1731311865885; 
 Sun, 10 Nov 2024 23:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEONrId/L+aw9mBOh5XBU+D85MPQX2IaJB2ww1D4KEeAACWT5cq2KODm8I69Cw+l4rxHFKP+Q==
X-Received: by 2002:a05:6402:234f:b0:5ce:c9d3:9fd7 with SMTP id
 4fb4d7f45d1cf-5cf0a31b925mr9575073a12.9.1731311865493; 
 Sun, 10 Nov 2024 23:57:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c7c41esm4652090a12.72.2024.11.10.23.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 23:57:45 -0800 (PST)
Message-ID: <52d92762-3e14-45f3-aca0-cf47c25a0116@redhat.com>
Date: Mon, 11 Nov 2024 08:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] tests/functional: Add microblaze
 cross-endianness tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20241108154317.12129-1-philmd@linaro.org>
 <20241108154317.12129-18-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241108154317.12129-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/11/2024 16.43, Philippe Mathieu-Daudé wrote:
> Copy/paste the current tests, but call the opposite endianness
> machines, testing:
> - petalogix-s3adsp1800-le machine (little-endian CPU) on the
>    qemu-system-microblaze binary (big-endian)
> - petalogix-s3adsp1800-be machine (big-endian CPU) on the
>    qemu-system-microblazeel binary (little-endian).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
>   .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
> index 2b2f782270..7f5e8b6024 100755
> --- a/tests/functional/test_microblaze_s3adsp1800.py
> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> @@ -36,5 +36,26 @@ def test_microblaze_s3adsp1800_be(self):
>           # message, that's why we don't test for a later string here. This
>           # needs some investigation by a microblaze wizard one day...
>   
> +    ASSET_IMAGE_LE = Asset(
> +        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> +        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> +
> +    def test_microblaze_s3adsp1800_le(self):
> +        self.require_netdev('user')
> +        self.set_machine('petalogix-s3adsp1800-le')
> +        file_path = self.ASSET_IMAGE_LE.fetch()
> +        archive_extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
> +        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
> +        time.sleep(0.1)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)
> +        exec_command_and_wait_for_pattern(self,
> +                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
> +                '821cd3cab8efd16ad6ee5acc3642a8ea')
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()
> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
> index 1aee5149fb..60543009ba 100755
> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
> @@ -38,5 +38,24 @@ def test_microblazeel_s3adsp1800_le(self):
>                   'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
>                   '821cd3cab8efd16ad6ee5acc3642a8ea')
>   
> +    ASSET_IMAGE_BE = Asset(
> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
> +         'day17.tar.xz'),
> +        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
> +
> +    def test_microblazeel_s3adsp1800_be(self):
> +        self.set_machine('petalogix-s3adsp1800-be')
> +        file_path = self.ASSET_IMAGE_BE.fetch()
> +        archive_extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'This architecture does not have '
> +                                       'kernel memory protection')
> +        # Note:
> +        # The kernel sometimes gets stuck after the "This architecture ..."
> +        # message, that's why we don't test for a later string here. This
> +        # needs some investigation by a microblaze wizard one day...
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()

Duplicating code is ugly. I think I'd rather prefer to merge the two files 
into one and then add that test to both targets in meson.build.

  Thomas


