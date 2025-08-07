Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA7AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujy4A-0008P4-J9; Thu, 07 Aug 2025 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujy48-0008FF-UZ
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:41:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujy45-0005l4-NN
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:41:44 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 577AfXKW045033
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 7 Aug 2025 19:41:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=t3FtZ61jwb6D20kXJO58wXtJtl2HLyzkJGzq2Fjw0IM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754563294; v=1;
 b=DuXKmOk2KTex32hH4afeT2wqZdByJg3mLFc3GsYTEWZ8Ios27XD7oYp9FEYm1+Ml
 9qB4fHcR27IcEFJs46z9h5KImMudW5tbO4v0ihDD7SiLnZuER3Ob0W+SPxVZic/F
 dcvU4QWwN08f/dzxuRdJd9DA4j0bq4bu6f1yD8s7fS40YzExqrBZH6opssK8k2dV
 XQBXt+4zZ2dtYWv3mu6ktsNcX5HEtBjsGN+IqnNGCz3dIqiCma8hN+f+HVNWwP65
 uTvOknkcxbv7sj6V8dYAV04QhvXSzaEpWCBUOk53EFQr/RfwdREutTQUvvegBQPR
 SrexpHoVjlQ16oLQTcHFVg==
Message-ID: <51a02882-9c8c-4353-8515-a90bbb8f88d4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 7 Aug 2025 19:41:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
 <36d5da25-8cae-40e0-bea4-47c6020b4f92@redhat.com>
 <e7a32cb5-9d60-4dd3-b8af-4dd734de2f03@rsg.ci.i.u-tokyo.ac.jp>
 <659004df-d0f8-40f0-82c3-ae747849d420@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <659004df-d0f8-40f0-82c3-ae747849d420@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/07 19:31, Laurent Vivier wrote:
> Removing totally the "if (msix_enabled(core->owner))" could introduce a 
> behavior change in the current implementation and I'd like to avoid that.

I failed to respond to this. There will be no behavioral change other 
than getting rid of the assertion failure.

If core->delayed_causes == 0, the latter part of this function is no-op 
and just returns 0. This is no different whether
"if (msix_enabled(core->owner))" is present or not.

If core->delayed_causes != 0, we had the assertion failure, but the 
assertion failure will be gone. The behavior after assert() was never 
present in the past, so we don't have to worry about behavioral change.

Regards,
Akihiko Odaki

