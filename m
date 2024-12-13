Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A229E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM1hX-0004Fp-CJ; Fri, 13 Dec 2024 04:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1hV-0004FB-5G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM1hQ-0008HL-4F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734081062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CQSvgI1tFw95N9E8rwpBb+eHgfFUtdICluECprPf/y8=;
 b=E8J+0O3Y6Pqkjw3cxe4JudvFk6yfnF8/VRYUoiJeoz5DSTPWEEnZylJ3YrmZlQlqg0NNDF
 exdiD9ynVoM4uDm65t46befnpbpxh/Gcg1QahSmu3IPMnhHRRrUpNgL2bR9lJa0ADBUDU7
 CjRDplP0es4L0IOCpgi7LVn/CRnnkw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-jl91BppVMHuebA_aRa1_tg-1; Fri, 13 Dec 2024 04:10:57 -0500
X-MC-Unique: jl91BppVMHuebA_aRa1_tg-1
X-Mimecast-MFC-AGG-ID: jl91BppVMHuebA_aRa1_tg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so14111535e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 01:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734081056; x=1734685856;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQSvgI1tFw95N9E8rwpBb+eHgfFUtdICluECprPf/y8=;
 b=t/Brgv9verSyWMyxEn8B1jIf1sOhFbLMz5UVeNuQ784huyJ+L/r4fB1MPcRDN5DeRC
 AzJZk1T14fwfUv1mrD94+Y+AIgC7ytdX+AVhi8hR4tZIivf3JT+oi8bHJSCOPevyTwBW
 53ODYeywT4npmhVY+ZlOgQ4mARGueh94upF7FDbanPnqMrS26vocS+TWJFCgaFDzd8Xm
 ujVSbRJvu2qaSUUGelFk32F2RmgnWak9heJ+K1f1gcX/WuyEm8PuN75rZkHRHpfuKJae
 6k/F7fnclrt8dSl3Lrw5tWwwtSiXxOolJ7ZS2CQvWdPKrriz7WzYaN8N/wABdBmqEQeb
 9ANw==
X-Gm-Message-State: AOJu0YwdcvtrW29OX6Sh+5xF4VGoKQVQxNgdnVFgKnbq3nHhm7fKe3Jg
 VZXoHdnvwbe/mM5rpN8XycsBq2gYqzLW9gPUudZMufu0BsUa6UgSHwuHRge4Loc08LLEarOzXlJ
 xMAocez8AICgSQIueRJaoJV6jLY90FugeoPsIfSST5IPk/AML4Pv3
X-Gm-Gg: ASbGncvzwIYQkfyULxja1IjdBZvzdiX7IO2BhtkE6e4V8EyjZGakId7xzglUhou2mh5
 p6Vid5dDhsdAi0OQSIHyT9/LkQVHzV27DKLzBAu7cJ0OLKEHyuBZ7tVP+w16MBwjZXj0QbUme1K
 0EKew65HTE669GYFCv2yft9sFD+fGPckkd1IntcBe9ursCD/8oKlszZ9r99c4o0wZ3+vp1RiaGB
 dbpsBtJ6Nlu8nzrYluX7Kb0xzD8bMqmI8mtk9DbIKRhTx0hx7FNktoQh73io+piuTc5aZtXIPju
 a3/WkA==
X-Received: by 2002:a05:6000:2a8:b0:386:3262:28c6 with SMTP id
 ffacd0b85a97d-38880ac2d54mr1160205f8f.5.1734081055953; 
 Fri, 13 Dec 2024 01:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbBsbDfaZbAaBgzskPiA1CftGylY1wlaiRGDc7xoJ1oxuWBkANhTBFnjaM3ozJBEJRnP2Tzg==
X-Received: by 2002:a05:6000:2a8:b0:386:3262:28c6 with SMTP id
 ffacd0b85a97d-38880ac2d54mr1160185f8f.5.1734081055574; 
 Fri, 13 Dec 2024 01:10:55 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824cab97sm6435643f8f.62.2024.12.13.01.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 01:10:55 -0800 (PST)
Message-ID: <f9f8f8f0-0ab9-4856-b84a-05e1ea8f4aa6@redhat.com>
Date: Fri, 13 Dec 2024 10:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/31] tests/functional: skip tests if assets are not
 available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-31-berrange@redhat.com>
 <0185be25-32f7-436b-b8e6-2e55c1cd0e18@redhat.com>
 <Z1r7CeI7TuHQXvAI@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z1r7CeI7TuHQXvAI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/12/2024 16.02, Daniel P. Berrangé wrote:
> On Thu, Dec 12, 2024 at 03:14:53PM +0100, Thomas Huth wrote:
>> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
>>> If downloading of assets has been disabled, then skip running a
>>> test if the assets it has registered are not already downloaded.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/functional/qemu_test/asset.py    |  8 +++++++-
>>>    tests/functional/qemu_test/testcase.py | 11 +++++++++++
>>>    2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
>>> index c5d3e73c4b..39832b2587 100644
>>> --- a/tests/functional/qemu_test/asset.py
>>> +++ b/tests/functional/qemu_test/asset.py
>>> @@ -65,6 +65,12 @@ def _check(self, cache_file):
>>>        def valid(self):
>>>            return self.cache_file.exists() and self._check(self.cache_file)
>>> +    def fetchable(self):
>>> +        return not os.environ.get("QEMU_TEST_NO_DOWNLOAD", False)
>>> +
>>> +    def available(self):
>>> +        return self.valid() or self.fetchable()
>>> +
>>>        def _wait_for_other_download(self, tmp_cache_file):
>>>            # Another thread already seems to download the asset, so wait until
>>>            # it is done, while also checking the size to see whether it is stuck
>>> @@ -103,7 +109,7 @@ def fetch(self):
>>>                               self.cache_file, self.url)
>>>                return str(self.cache_file)
>>> -        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
>>> +        if not self.fetchable():
>>>                raise Exception("Asset cache is invalid and downloads disabled")
>>>            self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>>> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
>>> index 7bece8738a..6c67a9459c 100644
>>> --- a/tests/functional/qemu_test/testcase.py
>>> +++ b/tests/functional/qemu_test/testcase.py
>>> @@ -184,6 +184,14 @@ def scratch_file(self, *args):
>>>        def log_file(self, *args):
>>>            return str(Path(self.outputdir, *args))
>>> +    def assets_available(self):
>>> +        for name, asset in vars(self.__class__).items():
>>> +            if name.startswith("ASSET_") and type(asset) == Asset:
>>> +                if not asset.available():
>>> +                    self.log.debug(f"Asset {asset.url} not available")
>>> +                    return False
>>> +        return True
>>> +
>>>        def setUp(self, bin_prefix):
>>>            self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>>>            self.arch = self.qemu_bin.split('-')[-1]
>>> @@ -209,6 +217,9 @@ def setUp(self, bin_prefix):
>>>            self.machinelog.setLevel(logging.DEBUG)
>>>            self.machinelog.addHandler(self._log_fh)
>>> +        if not self.assets_available():
>>> +            self.skipTest('One or more assets is not available')
>>
>> So if a test_*.py file consists of multiple subtests, this will now skip all
>> of them if just the asset of one subtest is missing?
> 
> Yep, I kept it simple. Often multiple assets all come from the same
> server (eg kernel + initrd), and the same assets are used across
> multiple tests.
> 
>> Could we maybe handle this test skipping in the new archive_extract() and
>> uncompress() functions instead, so that only the related subtests will be
>> skipped? (We still might need another wrapper function in testcase for the
>> spots that still call .fetch() on the assets directly, though)
> 
> I'm not sure its worth the effort to ensure we don't leave gaves in places
> that need skipping.
> 
> We still intend that this skipping scenario is highly undesirable at all,
> and want to try to ensure it never actually triggers. ie we want cache
> working in GitLab CI, so that we almost never need to download anything.
> 
> Most likely place to see skips is for developers locally if they're
> runing tests for the first time, or haven't done it for a long while.

Ok, fair point. Maybe it's even better to skip the whole test so that the 
whole test shows up as "SKIP" in the summary, otherwise we won't notice in 
the test summary if just one single subtest is skipped. So after thinking 
about this for a while, this is maybe even the better approach indeed.

Thus:
Reviewed-by: Thomas Huth <thuth@redhat.com>


