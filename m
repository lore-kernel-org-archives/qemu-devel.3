Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA1ACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZtB-0000aj-Gf; Fri, 19 Sep 2025 08:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzZsw-0000VM-1K; Fri, 19 Sep 2025 08:06:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzZsj-0007GB-Ju; Fri, 19 Sep 2025 08:06:41 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58JC5rvY060313
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 21:05:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zxBoene4j6Oa+6Rdc8pqs9GgvK8YJqS4410LfBRjQvI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758283553; v=1;
 b=uvafHsnROYeRDXjHLD5gqVuthxLsXuoGp0mmv7hIe4o+rxXaZMDfoo7QzwwrBug7
 2Z4WpsOPvmkBTXJqkoaGql9hI+ecPNDUPxi8CrBsKl6B1P+Ip0dEOl4E99Khs5ZR
 WhS7FKSUs65rVXrlrfJKsEOW7q8fvbs93/cAVYD/MWGFMf3cC2U8O2z6r8Li9lG+
 Ft/WyqtvdqSuj4xqgB6vlSAyGFItyFLhfQGpTtam44HLXG1eNmXrCCFeshLIwxPu
 +vEJRPYcvwwlBb0CpSUEkIIkx23YnrQ//jMpTqxEWCmZvVBeyRxmXdWRGhWxftK9
 8Epi68x1nvoOcXld48gSyg==
Message-ID: <3726af4b-55b3-4758-a61f-f38fc8f67648@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 19 Sep 2025 21:05:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/27] migration: propagate vTPM errors using Error
 objects
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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

On 2025/09/19 0:23, Arun Menon wrote:
> Hello,
> 
> Currently, when a migration of a VM with an encrypted vTPM
> fails on the destination host (e.g., due to a mismatch in secret values),
> the error message displayed on the source host is generic and unhelpful.
> 
> For example, a typical error looks like this:
> "operation failed: job 'migration out' failed: Sibling indicated error 1.
> operation failed: job 'migration in' failed: load of migration failed:
> Input/output error"
> 
> This message does not provide any specific indication of a vTPM failure.
> Such generic errors are logged using error_report(), which prints to
> the console/monitor but does not make the detailed error accessible via
> the QMP query-migrate command.
> 
> This series addresses the issue, by ensuring that specific TPM error
> messages are propagated via the QEMU Error object.
> To make this possible,
> - A set of functions in the call stack is changed
>    to incorporate an Error object as an additional parameter.
> - Also, the TPM backend makes use of a new hook called post_load_errp()
>    that explicitly passes an Error object.
> 
> It is organized as follows,
>   - Patches 1-23 focuses on pushing Error object into the functions
>     that are important in the call stack where TPM errors are observed.
>     We still need to make changes in rest of the functions in savevm.c
>     such that they also incorporate the errp object for propagating errors.
>   - Patches 12, 13, 20, are minor refactoring changes.
>   - Patch 24 removes error variant of vmstate_save_state() function.
>   - Patch 25 renames post_save() to cleanup_save()
>   - Patch 26 introduces the new variants of the hooks in VMStateDescription
>     structure. These hooks should be used in future implementations.
>   - Patch 27 focuses on changing the TPM backend such that the errors are
>     set in the Error object.
> 
> While this series focuses specifically on TPM error reporting during
> live migration, it lays the groundwork for broader improvements.
> A lot of methods in savevm.c that previously returned an integer now capture
> errors in the Error object, enabling other modules to adopt the
> post_load_errp hook in the future.
> 
> One such change previously attempted:
> https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html
> 
> Resolves: https://issues.redhat.com/browse/RHEL-82826
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

All comments I had are addressed and this series looks good to me.
For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

