Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC54D2E9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 11:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tASzl-0005MF-4j; Mon, 11 Nov 2024 06:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tASzj-0005LE-4V
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:54:11 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tASzh-0005zq-9A
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 06:54:10 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so7388162e87.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731326047; x=1731930847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JEK++LKY806mq5+PocjWhHbFaAgBYGWUfkUJ1LZ2s6o=;
 b=hw3QedX0sqa7rk1YjGuUjLA4Xfu4EQBO3hQJ1nPi6iCWoAYbjCDZLQhHr/E2PonI6i
 /9+92KCV8eZf8cscwPb1Hc91OCsvKkJjZnVO7tBvSGupbMm78DMyVFKChXW3ziLni6+e
 29+yG7wXoqr9IgRkjAkpqu0ds+AhsBiwMzv1K1du1ZxCRFh+e1gVykY+s+G4zGq8qkwD
 G3rscWzPHhWfDWv2PjxJZekCa5i5m/J7+IwLPSYUX/gDK5B6jnFltO3YtezBAmMjIvpv
 1r5kqw9C4XKVrbj0eSVz/OcGO2wIAeLGie0Fa1dhB0fsDQAjl2GXHCsggMUOTCx62kBQ
 +6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731326047; x=1731930847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JEK++LKY806mq5+PocjWhHbFaAgBYGWUfkUJ1LZ2s6o=;
 b=aqQZDA+IUurDHRco2iPKsgrfSX/ywfF7+y9GmoL6NPk/6h9rrqD/TW0ANdv7tOePW9
 Z41MKQ0DbKqYvhSrCgSqnaJOS4Zwj4OeWYP0qTkjLoiof0XkWuFAvJw2YnDmc1E1hXIM
 7TTVpopPVV39qheanaXIQm3Y1DvEeo2vPkJo26W36g6Oqp/P8zBRAIcthCMi+ORFSfGv
 zPt76W2Ee/khXRzg2lrqzzovlH7FBihT2yEW/4b7o00XwJaPrTpGQxl4ZKYNRS+s9+gR
 AunlPkn0VG8w+LjcnTMTrjI8suHByRL/eFYwq4aM2fyyMBzkqpibFczwgOFQyjgoN7Vk
 U1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdNjIDf8VrIx7L4tzA7TZ/8nw/KPoZm00kRbgykiUSctthYeoKZyPd/5yVXszN7XCuo7z3PlvUhV26@nongnu.org
X-Gm-Message-State: AOJu0YwdZTOSP1hC2yigUOZC2NtrU6Sp64UvszxtyZ/Fs+1NyOAJb7ch
 eAxQdDgAPMxPY3p835X8vi1XJ1w2OPBlF81QlXEDgr+mSlkBedPsgrwNjJk5NkE=
X-Google-Smtp-Source: AGHT+IFZZMZNcyvJy3q/3MNxOrrGgmL2feBCiFccmqnm3pPn8oWM2JNId21LINSERJy2NLFAiO2ojg==
X-Received: by 2002:a05:6512:b17:b0:535:6951:9e1c with SMTP id
 2adb3069b0e04-53d862c6dffmr7790701e87.15.1731326047038; 
 Mon, 11 Nov 2024 03:54:07 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0def535sm590036166b.140.2024.11.11.03.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 03:54:06 -0800 (PST)
Message-ID: <ffd30eb7-ed80-4b8e-8046-3e1fca14c35c@linaro.org>
Date: Mon, 11 Nov 2024 12:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] tests/functional: Add microblaze
 cross-endianness tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
References: <20241108154317.12129-1-philmd@linaro.org>
 <20241108154317.12129-18-philmd@linaro.org>
 <52d92762-3e14-45f3-aca0-cf47c25a0116@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52d92762-3e14-45f3-aca0-cf47c25a0116@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/11/24 07:57, Thomas Huth wrote:
> On 08/11/2024 16.43, Philippe Mathieu-Daudé wrote:
>> Copy/paste the current tests, but call the opposite endianness
>> machines, testing:
>> - petalogix-s3adsp1800-le machine (little-endian CPU) on the
>>    qemu-system-microblaze binary (big-endian)
>> - petalogix-s3adsp1800-be machine (big-endian CPU) on the
>>    qemu-system-microblazeel binary (little-endian).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
>>   .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/tests/functional/test_microblaze_s3adsp1800.py 
>> b/tests/functional/test_microblaze_s3adsp1800.py
>> index 2b2f782270..7f5e8b6024 100755
>> --- a/tests/functional/test_microblaze_s3adsp1800.py
>> +++ b/tests/functional/test_microblaze_s3adsp1800.py
>> @@ -36,5 +36,26 @@ def test_microblaze_s3adsp1800_be(self):
>>           # message, that's why we don't test for a later string here. 
>> This
>>           # needs some investigation by a microblaze wizard one day...
>> +    ASSET_IMAGE_LE = Asset(
>> +        
>> ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>> +        
>> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>> +
>> +    def test_microblaze_s3adsp1800_le(self):
>> +        self.require_netdev('user')
>> +        self.set_machine('petalogix-s3adsp1800-le')
>> +        file_path = self.ASSET_IMAGE_LE.fetch()
>> +        archive_extract(file_path, self.workdir)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
>> +        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + 
>> '/day13/')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
>> +        time.sleep(0.1)
>> +        exec_command(self, 'root')
>> +        time.sleep(0.1)
>> +        exec_command_and_wait_for_pattern(self,
>> +                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
>> +                '821cd3cab8efd16ad6ee5acc3642a8ea')
>> +
>>   if __name__ == '__main__':
>>       QemuSystemTest.main()
>> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py 
>> b/tests/functional/test_microblazeel_s3adsp1800.py
>> index 1aee5149fb..60543009ba 100755
>> --- a/tests/functional/test_microblazeel_s3adsp1800.py
>> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
>> @@ -38,5 +38,24 @@ def test_microblazeel_s3adsp1800_le(self):
>>                   'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
>>                   '821cd3cab8efd16ad6ee5acc3642a8ea')
>> +    ASSET_IMAGE_BE = Asset(
>> +        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
>> +         'day17.tar.xz'),
>> +        
>> '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
>> +
>> +    def test_microblazeel_s3adsp1800_be(self):
>> +        self.set_machine('petalogix-s3adsp1800-be')
>> +        file_path = self.ASSET_IMAGE_BE.fetch()
>> +        archive_extract(file_path, self.workdir)
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', self.workdir + 
>> '/day17/ballerina.bin')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'This architecture does not 
>> have '
>> +                                       'kernel memory protection')
>> +        # Note:
>> +        # The kernel sometimes gets stuck after the "This 
>> architecture ..."
>> +        # message, that's why we don't test for a later string here. 
>> This
>> +        # needs some investigation by a microblaze wizard one day...
>> +
>>   if __name__ == '__main__':
>>       QemuSystemTest.main()
> 
> Duplicating code is ugly. I think I'd rather prefer to merge the two 
> files into one and then add that test to both targets in meson.build.

In v2 I mentioned I'll merge them in a following up patch. I'll try
to do that for v4.


