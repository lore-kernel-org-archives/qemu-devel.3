Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F9EC1E84
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvm7-0002hF-5H; Thu, 05 Feb 2026 04:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvm5-0002gm-59
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:35:45 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnvm3-0001lj-Cm
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 04:35:44 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3545cf80e1dso327993a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 01:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770284142; x=1770888942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++l4A5mtnrtSPUE9IEtJhlCwr1t0zQWGNUCTgsc+nOI=;
 b=iSeWx8evbxBiJuxuOzCJ2F2CD+7opm8FrZQvqzXHcp0CbsEXJ6jh1jXDASL6lcx2Cf
 IbLI6RbA5793ACCd03Pcij0oMHUO/zrJZ6cQDwLr35ZnzBzU7y2bwcGKdVoPJGaR2PZw
 NeUzvMUu4NUNKwY8aFgXv5ZUYRynnHKsBrpNuq9i//9yAm6Zwqxxt4XCW6XMbjLNrHnn
 6fnxmcKkApxG1hyZCnKQRRgAN75S20KOh9UhURWR3ABMgPIutjgTYGfGPCeoY7lFO0zO
 /ELa6uxcFhD0kRY6y8SoKPjkLW71/ktEoOJBHRqoP2Bc445Wx8t8ZFvflIhUFqMLtXW+
 8gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770284142; x=1770888942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++l4A5mtnrtSPUE9IEtJhlCwr1t0zQWGNUCTgsc+nOI=;
 b=hWKkvxFNfhAvl7K0wNdNcSAIT99qSzuprWJZBiD3v14ent+TW4jnFaNqwaWiw5kzbZ
 IHtDqGf45JbCEZKnC5cZvD/GdFOMqDNAI/ww/4kVsCIF/JqJik6nD3bG9utZ1joC/ZiG
 gJto0/JINGSavGJ6h1qx2M60zxQuTO3enxOPUKgm2A9EqXDrjnCqufiquiVzsWvuh01h
 D9nmV7PZ6V+GXTPUdi4Bil0bXr7QaEEO7PLNDl5x94AfvqbYCkDfz0IRwDbuiMgurNs7
 FDXBIEGzXrYftaoJvbPU2A8QG+3tJcc47CJPHEAu+4OxPMzMC7X6dYz1sEpxDbqB1YQ5
 6CUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNaq5HMD0R4ERFvvVyC+KvESvAoC+1DJrjouyp9yEK6daNq6jaT0LYGA1iwbP1Y6IDwuRQRMsKCiJN@nongnu.org
X-Gm-Message-State: AOJu0YxNfR625SWOCCeK4PLIb8N1/R3yNB9tRUVtJnmcIIoV9LmlD2mh
 vtrvs3rigl3caL8v6FNTENsv98TZBBJ1IwYuJp5ZS2jhQosKeSBOMcQ6
X-Gm-Gg: AZuq6aLFVUQgldRLkjltmX5ATJM8TWjqNB214cM48aIVXyJo7d9gbX8hY0MgNHWcMNW
 hK4k5otDP+pCPqjqWbWUtbNZCMDvktjNTXOni6wzDbm8Im3SiCY81uWpRxfmt/m/ET3WqT/G5Mv
 AqyCSlazQB02cT1S6oXkpCVGNuT9wcFNKjLysE0SGyyNlGlvsJlPjFgO6HQiuIbM2ZXMrTObQpm
 zwdAmGTg0pAf/ITq+20mEKJo4v8kRMc3ZAjOvSV5pVSkMkhiJDpgMsQdbytEtdkivqtvX4z88CO
 45ZUHJ70AibhSMaRM1UJ4Wsqs5XP75PVNwj7NJfudkbS2uVuNM6135X19Ra4S7kyDboNw6N6WAi
 ii6X51eVMHUJbUAx1wtNZf6i8jtUd7JiVCHLAt5GCai0OZ3TnppY56vRoWKjTp78B3BiuXDiBqm
 w0j6yfL+DlXp91GINyFnrLEQ7jWMtz/YDmV4hI5+tJ12B6+Px+v8xmkNIfLFhikk0c8bU=
X-Received: by 2002:a17:90a:e70d:b0:354:7c90:8c6 with SMTP id
 98e67ed59e1d1-354871f3f42mr5397162a91.25.1770284141743; 
 Thu, 05 Feb 2026 01:35:41 -0800 (PST)
Received: from ?IPV6:240e:468:788:182d:c9a0:5302:cea5:79d2?
 ([240e:468:788:182d:c9a0:5302:cea5:79d2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354873a85d8sm1979929a91.3.2026.02.05.01.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 01:35:41 -0800 (PST)
Message-ID: <ac09572b-778e-4a6d-a080-aaa25decf977@gmail.com>
Date: Thu, 5 Feb 2026 17:35:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/2] tests/qtest: Add Intel IOMMU bare-metal test
 using iommu-testdev
To: Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org
References: <cover.1770172615.git.15fengyuan@gmail.com>
 <e43203cf-58aa-4642-8a2f-94b7a4a212ec@phytium.com.cn>
From: Fengyuan <15fengyuan@gmail.com>
In-Reply-To: <e43203cf-58aa-4642-8a2f-94b7a4a212ec@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=15fengyuan@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Tao,

Thanks for the attention!

On 2/4/2026 9:14 PM, Tao Tang wrote:
> Hi Fengyuan,
> 
> On 2026/2/4 11:06, Fengyuan Yu wrote:
>> Hi,
>>
>> This patch series adds a bare-metal qtest for the Intel IOMMU (VT-d) using
>> the iommu-testdev framework. The test exercises address translation paths
>> without requiring a full guest OS boot.
>>
>> Motivation
>> ----------
>>
>> The Intel IOMMU implementation in QEMU supports various translation modes
>> including pass-through and translated (4-level paging) modes. Currently,
>> comprehensive testing of these translation paths requires booting a full
>> guest OS with appropriate drivers, which is time-consuming and makes
>> regression testing difficult.
>>
>> This new test fills that gap by using iommu-testdev to trigger DMA
>> transactions and validate the IOMMU's translation logic directly.
>>
>> Test Coverage
>> -------------
>>
>> The new test provides:
>> - Legacy pass-through mode (identity mapping)
>> - Legacy translated mode with 4-level page table walks
>> - Root Entry Table and Context Entry Table configuration
>> - Complete 48-bit address space translation
>> - End-to-end DMA verification with memory validation
>>
>> Testing
>> -------
>>
>> QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>>    ./build/tests/qtest/iommu-intel-test --tap -k
>>
>> Thanks,
>> Fengyuan
> 
> 
> Thanks for working on VT-d qtests. As a first-time patch contributor, you’ve 
> already done a great job with good cover letter and commit messages to 
> accurately summarize your work.
> 
> 
> It seems that your code cannot be applied to the latest master branch. And I 
> also noticed multiple lines >80 columns (some > 90). QEMU style says try to keep 
> lines to 80 columns, only going a bit over when wrapping would harm readability 
> but never > 90 columns.
> 
> ../tests/qtest/libqos/qos-intel-iommu.c: In function ‘qvtd_build_root_entry’:
> ../tests/qtest/libqos/qos-intel-iommu.c:168:31: error: 
> ‘VTD_CONTEXT_ENTRY_SLPTPTR’ undeclared (first use in this function); did you 
> mean ‘VTD_CONTEXT_ENTRY_SSPTPTR’?
>    168 |     lo = (context_table_ptr & VTD_CONTEXT_ENTRY_SLPTPTR) | 
> VTD_CONTEXT_ENTRY_P;
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
>        |                               VTD_CONTEXT_ENTRY_SSPTPTR
> ../tests/qtest/libqos/qos-intel-iommu.c:168:31: note: each undeclared identifier 
> is reported only once for each function it appears in
> ../tests/qtest/libqos/qos-intel-iommu.c: In function ‘qvtd_build_context_entry’:
> ../tests/qtest/libqos/qos-intel-iommu.c:190:25: error: 
> ‘VTD_CONTEXT_ENTRY_SLPTPTR’ undeclared (first use in this function); did you 
> mean ‘VTD_CONTEXT_ENTRY_SSPTPTR’?
>    190 |              (slptptr & VTD_CONTEXT_ENTRY_SLPTPTR);
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>        |                         VTD_CONTEXT_ENTRY_SSPTPTR
> ../tests/qtest/libqos/qos-intel-iommu.c: In function 
> ‘qvtd_setup_translation_tables’:
> ../tests/qtest/libqos/qos-intel-iommu.c:239:36: error: ‘VTD_SL_R’ undeclared 
> (first use in this function); did you mean ‘VTD_SS_R’?
>    239 |     pml4_entry = QVTD_PT_L3_BASE | VTD_SL_R | VTD_SL_W;
>        |                                    ^~~~~~~~
>        |                                    VTD_SS_R
> ../tests/qtest/libqos/qos-intel-iommu.c:239:47: error: ‘VTD_SL_W’ undeclared 
> (first use in this function); did you mean ‘VTD_SS_W’?
>    239 |     pml4_entry = QVTD_PT_L3_BASE | VTD_SL_R | VTD_SL_W;
>        |                                               ^~~~~~~~
>        |                                               VTD_SS_W
> [92/2328] Compiling C object libblock.a.p/block.c.o
> 
> 
> 
> Besides when submitting patches it’s a good idea to read `docs/devel/submitting- 
> a-patch.rst`. It may be a bit long, but making sure the code builds cleanly and 
> running scripts/checkpatch.pl for style checks beforehand can help avoid many 
> basic issues.
> 
> 
Thank you for your reply, and I sincerely apologize for my oversight.
I have identified the issue: since I started development on iommu-testdev 
earlier, some Intel IOMMU macro definitions changed during my development, 
causing them to be undefined.
I will include comprehensive CI/CD checks and patch verification in v2.

> Finally I think CC the experts on x86 and VT-d emulation might be a more 
> efficient way to review this sereis patch.
> 
> M: Paolo Bonzini <pbonzini@redhat.com>
> R: Zhao Liu <zhao1.liu@intel.com>
> 
> M: Michael S. Tsirkin <mst@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
> R: Yi Liu <yi.l.liu@intel.com>
> R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> 
Okay, I will cc these reviewers in v2 submission.

Thanks,

Fengyuan

> Anyway I'm looking forward to your v2 patches.
> 
> Best regards,
> 
> Tao
> 


