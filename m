Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2680C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU09m-0003Xh-Jx; Tue, 24 Jun 2025 05:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uU09Z-0003Ww-Jd
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:41:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uU09U-00029K-5f
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:41:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a522224582so117743f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750758072; x=1751362872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRJcDtB9l9A1HQrfrg56zKM/wSiyHn3H6PcFGXvFnNs=;
 b=nzLMTshqZWscWvCKn9xazdUXOnF/dV9t1Xn3Z6NMvVxAxmd6E+vh+STbKr85HZBTTN
 4uRwflarvxBvq3LtH/dVZdXLt37xanuYp2/R/z1R5Ucf6MqYCHrSYOTgD7uljk4NWttx
 X5j9LU5ASkv24acODFtcXz8oUMN2UC6+r45V2p0v9AuRcwdCH+ez+YIHFnRBiRjVD240
 l6+HTuNgn2WHm8moL1HPno2WttRMOTTeM0/eOhxmE9f0DYa3lPO3BoZy8fIg62nvLGm8
 YSFcdW/lGvRH/164bl05s2T2eRWjRLnzI6sK+2gC32hKvEUf6XCQOvDUtZBGLI5hqBxP
 wHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758072; x=1751362872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRJcDtB9l9A1HQrfrg56zKM/wSiyHn3H6PcFGXvFnNs=;
 b=U8nQcNfn4WtRQN5B5wqnU3MtFH8oEGwuHUesdIXABXssDIM52GPvrbqqKADUXVfZYC
 Qb+z/BUfaOaKAE3GEPeQbB8A6jWOBfVTutqMMpIZQJd0h7y59bBla/hamZ+aCEx9OetK
 lSpwXzX3qJKZCYmfe+PsPH40x8Q4eHHqlSk5jI249uqdhhatWLiLRjOev4nAK+E4drSA
 FR5cUp0teruqgzTKWWDuAD57MlQIOEHkQXlE3nEGcw1QVmBknwA64aIcaK69nnmmEG0o
 2k6+rUD5NqQ0QlkxNOQIunG3Ex8r3RlZc6SeprLFfeZZhhyBubNdg3H4b6jBEukBZF7f
 5dAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3C0vbhYrIEpCgUy1hw5PPQ4Z70vAsG7GhYpksnmWbwElWukNb6C7ATHUPmJckGfF0u+JSmmsPDO4n@nongnu.org
X-Gm-Message-State: AOJu0YzFf8S02VjQuSV0lpeQLGTMS8Es6Ic7RbR70nPdCb6+cTTqpQO6
 UeTVyAlvjwbtr961r0zyqk0aJG/Tz86wpTv3ihdhT6dDRGGUT1j5oeVOc3ptEsV68uw=
X-Gm-Gg: ASbGncuGSQRKe2YPqMZM/oNOEqrS8gwy3ifwcJd2KpVvLmgSjaBkzMXjIszRW5rHtHr
 X2ELxuXIJKlbeOa+BUu2++effZw8yTAqBppoUVmUiN1Yc6R16QZL8b8Gdaz7pMlBXw7rcEyTmGB
 x84jvbyhplNXxtU920+idHkXnq2MMWQH4YC3aiT7Y8J7kAC8WhYQxBFjdv7JnGuENxxzsC1h/Cd
 3dNSFV3jXv3/Aukp9pZOyBcFjlcQt/vItSbbs8ewRwagJXPSep2tGlqV2I7p5ugJYd4lLyOX3Pt
 YcVYLorfrV3UQHQrFPuZmfFtV5pbRg9YorLW6JnHBaUocDkczmpinNsx4uAzQDvil27pqRbSkWz
 06mwJ+dkB5wUlYSS7ImogyiUJtcgo/w==
X-Google-Smtp-Source: AGHT+IGi846n02tgzu9iRKMG3F8wvAica6zf0mqhIkiVA/4H55EvScotpHWizU/scSbEhEhlW0VXsw==
X-Received: by 2002:a05:6000:649:b0:3a3:7753:20ff with SMTP id
 ffacd0b85a97d-3a6d12da180mr13830764f8f.35.1750758072496; 
 Tue, 24 Jun 2025 02:41:12 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e805d21fsm1463517f8f.23.2025.06.24.02.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:41:12 -0700 (PDT)
Message-ID: <375ba89e-576e-4791-9399-8e2f936ab0ce@linaro.org>
Date: Tue, 24 Jun 2025 11:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add license tag to some files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aFpqaC8HGEK5A7dV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/6/25 11:05, Daniel P. Berrangé wrote:
> On Tue, Jun 24, 2025 at 10:34:40AM +0200, Cédric Le Goater wrote:
>> + Daniel
>>
>> On 6/23/25 11:30, John Levon wrote:
>>> Add SPDX-License-Identifier to some files missing it in hw/vfio/.
>>>
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>> ---
>>>    hw/vfio/trace.h      | 3 +++
>>>    hw/vfio/Kconfig      | 2 ++
>>>    hw/vfio/meson.build  | 2 ++
>>>    hw/vfio/trace-events | 2 ++
>>>    4 files changed, 9 insertions(+)
>>
>> I think that's OK to add a GPL-2.0-or-later SPDX tag on these files
>> because they are simple infrastructure files, and we know when they
>> come from. How useful it is ? that I don't know.
>>
>> For other source files, without a license, if we have any, I think
>> the answer would be much more complex.
>>
>> Daniel, What would be our position on such files ?
> 
> The only hard requirement we have stated is that all /newly/ created
> files ("new" as in git patch reports it as a new file) must have the
> SPDX tag, and must NOT have license boilerplate. This is enforced by
> checkpatch.
> 
> We are NOT expecting SPDX tags to be added to existing files in
> general, whether they have a license boilerplate or not.
> 
> Adding SPDX tags to existing files without any boilerplate text
> at all is likely the more interesting & beneficial scenario
> though.
> 
> If adding SPDX tags to existing files, you must do due diligence
> over the history of the file, in order to validate the implicit
> license it would have had based on QEMU's rules when the file was
> first created. We can't just blindly assume it was GPL-2.0-or-later,
> as it might have been copied from elsewhere when first created and
> thus inherit terms from another file.
> 
> For the specific 4 files in this patch, I think it is unlikely there
> will be any surprises in their license history though. They all post-date
> our top level  statement that new contributions are implicitly
> GPL2.0-or-later, and also won't have been copied from elsewhere.

Commit 6b620ca3b05 ("prepare for future GPLv2+ relicensing") from
2012-01-13 (and 8571fa57cd0 "LICENSE: clarify"):

Author: Paolo Bonzini <pbonzini@redhat.com>  2012-01-13 17:44:23
Committer: Anthony Liguori <aliguori@us.ibm.com>  2012-01-13 17:55:56

     All files under GPLv2 will get GPLv2+ changes starting tomorrow.

added:

+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.

IANAL but IIUC we could add "SPDX-License-Identifier: GPL-2.0-or-later"
to all files added after 2012-01-13 which don't contain any license...

So if these files were added after 2012-01-13, then the patch would be
OK IMHO.

