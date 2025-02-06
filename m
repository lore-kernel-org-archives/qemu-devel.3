Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02EC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Yh-00008r-Ls; Thu, 06 Feb 2025 13:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Yf-00007v-MG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:25:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Yd-00083R-JP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:25:01 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so13852115e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738866298; x=1739471098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UEHokQ/tlwrnv9GfhI4Ppqv6w6OxNGWo4cEqfNX/KA0=;
 b=DdhT+rD9TIKmvnCLzlIiwVFZRSP5L7m0AiSL7NfH90+ebdaDu4qBEzS5PhktpRTdYf
 LILT9H77HY0gPNNYVjfm1XNjn4twhha79c7trL8RPXSc+OYQEVvFbZLfaf2CQPPXgtMx
 Yd0JX5BFhyTB2ZFFEaThIQ71aGx743fysMguZfFBrL6X4RB4DRFmfD0kBdBCKpHu55St
 mfaEY9t410dK28V9GVy1jMOF/Yw/G5xdbKiXEPngsGZMFir0zs5bKkims3lpT3vEM7aR
 K/QhFmJCvng9pn4Flbn/pi5am4Pmg3cN3E61JdsIIPd5KixCcULjtexBTdn8iMrhRKRg
 AMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866298; x=1739471098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEHokQ/tlwrnv9GfhI4Ppqv6w6OxNGWo4cEqfNX/KA0=;
 b=cS3ZnKwLclarlrA6EyUxbhNDpZW9iOHiBiVmrB1UrQl+fWEjslzbmRAGGJcWMhecz3
 4lk59/7OlKFbo6cgHXr7ACSOh8EVHSl75iDDX3jupSok95SsL4r493omrc7m4nlOjmkt
 fEVw3riI/NDNPj7J9oKK07q33r4PwBxDJhuri9Kg74T1pplhpZghMmIxq5d3YNWU1Fwa
 /jcFoTAWwKgenHE86sOceCpw7o4RMRdO/rqPmWELR7dd0PphD6HQPLoXXHsy71xK2ORe
 eG0L6wD7MVWI57hoPtVpbB7G5Pw2+WA20LVZbs+VI8XsMqMlOU/xtsOCY3pGsxZDLv5i
 R4MA==
X-Gm-Message-State: AOJu0YzuX2uYfYz1zyD3TOk1t8in92ipFbS0vCBDm1dvAva6+48m6KcO
 UEI9v4f86MdOluMuAYyYSDbJcVSBSA0/PguHBbXh1xw/VlZKOAXX8DYWSrdbwok=
X-Gm-Gg: ASbGnctWLcuQGCVAF0EX6bdtGsxo442vwSVQJkwb+fJFCfCNka1JWZ7PHTS5GsJ9CvU
 CUWckz5bqwi8y782XeEhLrX9t7CSEJMsBSPMlNDAqMEV5BTVq+a2X4M6LsWhGnY5t3C4XtSOEt1
 N+XPU4ASpXjhD2HusPL+A2eEgizt/yVO67H6vc6oyaSZ8iwpzesWp4nkrKiYOTtl+Tsvk3C1RJg
 ODgPNY6B+LhvnBTU1mRnZ29Ufc8RyJOp/5iRuMjjSPjFMg3aTQejKgY8zm+63XOHNHGY7bACPay
 5RDoYifTRNsc7I3N6qHuXgbO0UH/mwptJxKJOOi4pM1pdW6gzNTU2HEuhb4=
X-Google-Smtp-Source: AGHT+IFsypa0N3DQFPf++qwmW0XY2J1A300ZSUz3PvdOg+EGsLUyrbJN28kNphkG7hLb1OCfwKzwFQ==
X-Received: by 2002:a5d:6d84:0:b0:385:f638:c68a with SMTP id
 ffacd0b85a97d-38dc8deae54mr40551f8f.30.1738866297741; 
 Thu, 06 Feb 2025 10:24:57 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde33e86sm2379379f8f.97.2025.02.06.10.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 10:24:57 -0800 (PST)
Message-ID: <ce653340-1375-41b5-bebb-c7089d3ab2bb@linaro.org>
Date: Thu, 6 Feb 2025 19:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michal Simek <michal.simek@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
 <Z6TtisO7JGAMGILH@redhat.com>
 <63f1130e-a30d-4416-ae74-374f1fd94dbe@linaro.org>
 <Z6T6CiL_F-LvLGel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6T6CiL_F-LvLGel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+Michal

On 6/2/25 19:06, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 06:49:38PM +0100, Philippe Mathieu-Daudé wrote:
>> On 6/2/25 18:12, Daniel P. Berrangé wrote:
>>> On Thu, Feb 06, 2025 at 04:04:20PM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>>>>> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Daniel,
>>>>>>
>>>>>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>>>>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
>>>>>>>> Introduce an abstract machine parent class which defines
>>>>>>>> the 'little_endian' property. Duplicate the current machine,
>>>>>>>> which endian is tied to the binary endianness, to one big
>>>>>>>> endian and a little endian machine; updating the machine
>>>>>>>> description. Keep the current default machine for each binary.
>>>>>>>>
>>>>>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>>>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>>>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>>>>>
>>>>>>> Does it makes sense to expose these as different machine types ?
>>>>>>>
>>>>>>> If all the HW is identical in both cases, it feels like the
>>>>>>> endianness could just be a bool property of the machine type,
>>>>>>> rather than a new machine type.
>>>>>>
>>>>>> Our test suites expect "qemu-system-foo -M bar" to work out of
>>>>>> the box, we can not have non-default properties.
>>>>>>
>>>>>> (This is related to the raspberry pi discussion in
>>>>>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1-philmd@linaro.org/).
>>>>>>
>>>>>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>>>>>> remove it we can merge both qemu-system-microblaze and
>>>>>> qemu-system-microblazeel into a single binary.
>>>>>>
>>>>>> If you don't want to add more machines, what should be the
>>>>>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>>>>>> with no particular endianness? Either we add for explicit
>>>>>> endianness (fixing test suites) or we add one machine for
>>>>>> each endianness; I fail to see other options not too
>>>>>> confusing for our users.
>>>>>
>>>>> We would pick an arbitrary endianness of our choosing
>>>>> I guess. How does this work in physical machines ? Is
>>>>> the choice of endianess a firmware setting, or a choice
>>>>> by the vendor when manufacturing in some way ?
>>>>
>>>> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
>>>> (wired to a CPU pin which is sampled once at cold reset).
>>>
>>> That makes me thing even more it is just a machine type property.
>>
>> I'm happy with a machine property, this was even my first approach
>> using OnOffAuto until I ran the test-suite and have qom-introspection
>> failing.
>>
>> What should be the default?
>>
>> Per the SH4 datasheet:
>>
>>    Bit 31—Endian Flag (ENDIAN): Samples the value of the endian
>>    specification external pin (MD5) in a power-on reset by the
>>    RESET pin. The endian mode of all spaces is determined by this
>>    bit. ENDIAN is a read-only bit.
>>
>> There is no default per the spec, and I believe using one is
>> a mistake.
> 
> If it is left as an unspecified choice in the spec, then I would
> presume HW vendors are picking an option based on what they
> expect "most" common usage to be amongst their customers. IOW,
> if we know of typically used guest OS prefer big or little, that
> could influence our choice.

Please have a look at this thread:
https://lore.kernel.org/qemu-devel/d3346a55-584b-427b-8c87-32f7411a9290@amd.com/


