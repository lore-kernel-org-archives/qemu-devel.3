Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9641D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1Nr-0007J6-CO; Mon, 18 Nov 2024 08:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD1Nk-0007Hk-EL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:01:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD1Nh-00072u-Pw
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731934888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jASOsyxd/Wr94psTld4d/Cckqkh/wlYO6xU/+OiNcDI=;
 b=gsojfvakr5DqIhwnenX5pujgtgQ5Wq0tb+eFLb8sBewjjfo8svEvBG1NUxTYLkkQLNVhmH
 zo3t16LOp0ArARGnkXX973/t4A+5u1aflal1Ld5ri0MX/iYiLcXDXDi/SPVx2TkB51xZiX
 CoOw5JKOce8F30sSRDILOGTzra875pI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-znCO0wa4O3qUhGPNeOH4Eg-1; Mon, 18 Nov 2024 08:01:26 -0500
X-MC-Unique: znCO0wa4O3qUhGPNeOH4Eg-1
X-Mimecast-MFC-AGG-ID: znCO0wa4O3qUhGPNeOH4Eg
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-460ba8f6a5aso41824161cf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934886; x=1732539686;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jASOsyxd/Wr94psTld4d/Cckqkh/wlYO6xU/+OiNcDI=;
 b=E604VDT2PaSnX2ynh1ycBSZeegJ8/N9XKFGq1On76QnUJ/EQrkJR5dPD4lhmyWt864
 f5S7uVZZC2Cu90SvJsbuXhdkLLUONAT8dLznoZL7ErsQP785YtysZHmTb93ERtcvsM7c
 G9ETwY13HlHMNbAIRr/skH4nUktugKznABaiEAE1tRdPKyZHEKclWug7YGf7xJ47ah9l
 drf3TtWyAosX/nymtuNHc9YKxXeVccMnhUjFSUO/yuD4zhRLnKiQMxOHuviBZnJc8sjN
 MW3KsRhidejRBcLizGclws3Cg7GwbRm1NB5O7RIuhVtrGDqo+ph7i7Z6YXb3ySp721c0
 cWBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsH2MmEPmS8uSFKf/6L4uu0pKynp7KwSmXoLjSq9OahZfhdw0ULHYfwssoLANZypOuYQhPHo3XqMuI@nongnu.org
X-Gm-Message-State: AOJu0YzklcA+gUy6sNSiIt1TowswYfBCW0UVMCjUln0OJRvH6bH2Xx6Q
 hJb6qk9vH0X6ubwQm1wZeNCZmLpwxc2hIXO1BeZ50uuFW9BBnl09s4SVwIoEVOduFZzcKuLTb/1
 zoVBLHJ/51MS87nO7KjcKKcezKCqXl4PJtfC6RoET6eTYHV5Ah4NU
X-Received: by 2002:a05:622a:4b10:b0:458:3a5a:94a5 with SMTP id
 d75a77b69052e-46363de8df2mr177816681cf.2.1731934886075; 
 Mon, 18 Nov 2024 05:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0Qvt36DV31NrIOTSxy41LIqr39iWiNeDbTyn/glSM3ZPB2CvBf1Zoq9+qh7oHJw0VdxfVOw==
X-Received: by 2002:a05:622a:4b10:b0:458:3a5a:94a5 with SMTP id
 d75a77b69052e-46363de8df2mr177816231cf.2.1731934885645; 
 Mon, 18 Nov 2024 05:01:25 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-145.web.vodafone.de.
 [109.42.48.145]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f23besm58065451cf.30.2024.11.18.05.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 05:01:25 -0800 (PST)
Message-ID: <c3fcead1-3f3e-41bc-aac9-31a2eb3a8306@redhat.com>
Date: Mon, 18 Nov 2024 14:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/functional is eating disk space
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
 <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
 <Zzs5hKLic2XU4FBc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Zzs5hKLic2XU4FBc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/11/2024 13.56, Daniel P. Berrangé wrote:
> On Mon, Nov 18, 2024 at 01:10:14PM +0100, Thomas Huth wrote:
>> On 18/11/2024 11.57, Peter Maydell wrote:
>>> I just ran out of disk space on my dev machine, because:
>>>
>>> $ du -h build/clang/tests/functional/
>>> [...]
>>> 11G     build/clang/tests/functional/
>>
>> That's indeed a lot. I only got 6.9G in my build tree for all targets ... I
>> guess there are some stale files lying around, so as a temporary mitigation,
>> just try to delete that folder (it should get recreated the next time you
>> run the tests).
>>
>>> The new functional tests seem to be eating disk space.
>>>
>>> Even the build tree I have that's just arm targets is 7.1GB.
>>>
>>> Could you have a look at what's happening here?
>>
>> I am aware of the problem and got it on my TODO list already... I think we
>> best should set the "workdir" to a temporary folder that we can remove once
>> the test has finished, that will automatically delete all binary assets that
>> the test created during its runtime.
> 
> workdir also stores the logs currently, which we want to preserve, but we
> can just move assets to a sub-tree instead. Something approx like this:

Yes, this is pretty much similar to what I had in mind! ... do you maybe 
want to send it as a proper patch?

> @@ -40,11 +42,11 @@ def setUp(self, bin_prefix):
>           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
>           self.arch = self.qemu_bin.split('-')[-1]
>   
> -        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
> -                                    self.id())
> -        os.makedirs(self.workdir, exist_ok=True)
> +        self.outputdir = Path(BUILD_DIR, 'tests', 'functional', self.arch, self.id())
> +        self.workdir = Path(self.outputdir, 'scratch')
> +        self.workdir.mkdir(parents=True, exist_ok=True)
>   
> -        self.logdir = self.workdir
> +        self.logdir = self.outputdir
>           self.log_filename = os.path.join(self.logdir, 'base.log')
>           self.log = logging.getLogger('qemu-test')
>           self.log.setLevel(logging.DEBUG)
> @@ -56,6 +58,8 @@ def setUp(self, bin_prefix):
>           self.log.addHandler(self._log_fh)
>   
>       def tearDown(self):
> +        if not "QEMU_TEST_SKIP_RMTREE" in os.environ:

I'd maybe call it "QEMU_TEST_KEEP_SCRATCHDIR" instead... but that's just 
bikeshedpainting.

Anyway, we'd then also need to document the env variable in 
docs/devel/testing/functional.rst, I think.

  Thomas


> +            shutil.rmtree(self.workdir)
>           self.log.removeHandler(self._log_fh)



