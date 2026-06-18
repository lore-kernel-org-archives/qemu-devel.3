Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB810CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDx0-0008J1-FK; Thu, 18 Jun 2026 10:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waDwr-0008IH-Ar
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waDwm-00066I-OT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781793743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHj4In9zAi2tjAg62LbwpzitxOBTLWVYjrgXfOPJKik=;
 b=WzQH6G45+TCnuIxIB8A8WKzfgU9guTKKyFsoUZGyUx41mLGo3NNF8rqG7ogLPbnMZ7VjmG
 cwh3Ys7CYpWmkrLIYbPTXQ2dRBKH3TS04kkBSFfZW/K6mJKx5qqQQEvSf4WSEcsc3f6sGB
 Zs8nXd3JkTuzgpHz/8RfVYcmHGk1/PA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-6pBJd1WCOfiwyc11IT6FfQ-1; Thu, 18 Jun 2026 10:42:21 -0400
X-MC-Unique: 6pBJd1WCOfiwyc11IT6FfQ-1
X-Mimecast-MFC-AGG-ID: 6pBJd1WCOfiwyc11IT6FfQ_1781793740
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so6776315e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781793740; x=1782398540; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SHj4In9zAi2tjAg62LbwpzitxOBTLWVYjrgXfOPJKik=;
 b=U66/xRkr5IH3XfLXp6oizO4mWCEkwHdQVSprunucSaEJW+AqaeYxcNY/Wf08Tt5RtU
 c0z+LxfmHuoihTgYtNEHi9uA3PXWEY+xDTkzDq71Hd3Q+dFLSwb2S0JZLkpyMM9l4cBw
 3DpRgMde3oYrBsQHZjP8kDKyOb4GUtfRGvZ/A1Z8uwK1acWPfgTxhrs65u+SK5MzrSEi
 Lj7pU35/M0GbCdlWzK2BWulRVtMoQSvXdV+2ioKo/CbLjuOHraKNaTVGbnd6KOTE3Sdc
 WclsENVjRPZV+6YghGPdDtZzvxlRG+LHSr925G+NFtCBgIoUCQV9bSY/0bTtATo4guZl
 Ging==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793740; x=1782398540;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SHj4In9zAi2tjAg62LbwpzitxOBTLWVYjrgXfOPJKik=;
 b=fB6KqVAjHacrL3RSWjiCAj9UbIgAWmwAzZ5lsH4MXwqqMSau6eyqm2UtckbahJST7X
 h3aUJEn2lySNNvj6Z5s8gJukXdnpsOPjMLI1/k61VVG5OVvfq1dkJuetoJQ5t8bAunyP
 wq4rpwN1oiPgEXlSJ1qsbgXQkyKuLunXkrREsq9+5pg/v1TDT8l+wPTEYhZtk6s4s36p
 10hQopKgqIgjyTH6KZYHrffVBwPwxrcLqWGWrbh3KsUwt1SbDtkDfcAm88zIbMz/h+A1
 a696BJqzq8Q+Uu1jYLDEjR185beAltEJ9gj//ZTPAWiaSfqVNbcbTZDT8tgc7b1oT5SR
 9L8A==
X-Gm-Message-State: AOJu0YxyIeyQ99c/BsUQRTn/it3ZYND/YEryDol8K//yyWKqY4bd1UJ4
 WBdII1GHKt0RwtpmyHKWSQSTr1u9QhR9ABjNup+gi/rZguAwrMTfFGgKMkCjcWczzAU+oC8D1lI
 mrU772EkAjg2TGBISsxcCy6MaXw2WdgPiuWTRCBhrhPVjWErM4xG3boLMD1bpuCCk
X-Gm-Gg: AfdE7cm/fzkY/BBxuarl1I0Q6bZFqlDK4DSGQTQ8XETzGHlsvx0fw2/pI0OwJRmUm3m
 rOeutqIwV/D4KeVjJ4Ppj46lMV2sRspWsDrkKUuvwu/yphLKfsCQ4rrocemvwC3XqWdiOo7i2lX
 Lmdh8B9lNAi5jKUnY7Zm+g55wBgTPEryNxzQKyV+YiGMF8uRZ2koMJb59n340iyCRqn0s83anNh
 9wl7MMDdL3KYSn2BkOv9jWvIgV57wzhQVfgfAzy0PQoBIziyIPLBB4Z1xvm0MAtsy+q8i/iRhpK
 UCci5/hKAkUqkpOHSgQLkYmRjXI/BcURQMpZLYei3wQ2NFua93IsccEZu0EvnQnClPmbgJoLfgb
 DmDLNk19jKj837j3Sj1BSWef2iTMkyGMD
X-Received: by 2002:a05:600c:c170:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-4923341fbdemr145987495e9.20.1781793739678; 
 Thu, 18 Jun 2026 07:42:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c170:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-4923341fbdemr145986755e9.20.1781793738818; 
 Thu, 18 Jun 2026 07:42:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ebe3sm209149705e9.11.2026.06.18.07.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:42:17 -0700 (PDT)
Date: Thu, 18 Jun 2026 10:42:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618104051-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618132058.1044341-4-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 18, 2026 at 02:20:58PM +0100, Daniel P. Berrangé wrote:
> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
> 
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.
> 
> The focus is on making issues public as soon as possible with
> a viable patch. Co-ordinated disclosure will no longer be
> attempted and nor will requests to embargoes be accepted.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks for taking on this. One question:


> ---
>  contribute/report-a-bug.md     |   9 +-
>  contribute/security-process.md | 309 +++++++++++++++------------------
>  2 files changed, 148 insertions(+), 170 deletions(-)
> 
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index fd3bc6b..b506f9f 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -11,6 +11,11 @@ on GitLab, taking into account the following guidance.
>    requested pieces of information that are relevant to the
>    discovered bug.
>  
> +* Bugs which are suspected, or known, to have security implications
> +  **must** be marked as "*confidential*" prior to submitting the
> +  disclosure. Consult the [security process](../security-process)
> +  for further guidance on security issue handling.
> +
>  * Reproduce the problem with the latest upstream QEMU release.
>    Reports against older versions may not be acted upon with
>    with the same priority.


There's a problem here in that confidential marking is later
erased. I feel would is benefitial to tag the security bugs
in some way that does not go away so easily. Any idea?


> @@ -37,10 +42,6 @@ on GitLab, taking into account the following guidance.
>    guidelines](../submit-a-patch/). QEMU does not use a merge
>    request workflow for contribution.
>  
> -* Do NOT report security issues (or other bugs, too) as "confidential"
> -  bugs in the bug tracker.  QEMU has a [security process](../security-process)
> -  for issues that should be reported in a non-public way instead.
> -
>  * If the problem is believed to lie in the KVM kernel module,
>    following the [KVM wiki bug report](https://www.linux-kvm.org/page/Bugs)
>    guidance to submit an issue to the kernel bug tracker.
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> index 5c708f5..c091fa1 100644
> --- a/contribute/security-process.md
> +++ b/contribute/security-process.md
> @@ -3,169 +3,146 @@ title: Security Process
>  permalink: /contribute/security-process/
>  ---
>  
> -Please report any suspected security issue in QEMU to the security mailing
> -list at:
> -
> -* [\<qemu-security@nongnu.org\>](https://lists.nongnu.org/mailman/listinfo/qemu-security)
> -
> -Note that not all areas of QEMU are considered to provide a security
> -boundary. Consult the guidance at the end of this page for further
> -information on how QEMU classifies issues as security vulnerabilities
> -vs regular bugs.
> -
> -## How to report an issue:
> -
> -* Please include as many details as possible in the issue report.
> -  Ex:
> -    - QEMU version, upstream commit/tag
> -    - Host & Guest architecture x86/Arm/PPC, 32/64 bit etc.
> -    - Affected code area/snippets
> -    - Stack traces, crash details
> -    - Malicious inputs/reproducer steps etc.
> -    - Any configurations/settings required to trigger the issue.
> -
> -* Please share the QEMU command line used to invoke a guest VM.
> -
> -* Please specify whom to acknowledge for reporting this issue.
> -
> -* If any automated tools (AI/LLM based, traditional static
> -  analysis, or fuzzers) were used to discover the issue, the
> -  reporter is required to declare this at the start of the
> -  security report. Users of such tools are required to perform
> -  triage of their output. Findings and reproducer scenarios
> -  output by automated tools must be validated prior to submitting
> -  an issue to the QEMU security team.
> -
> -## How we respond:
> -
> -* Process of handling security issues comprises following steps:
> -
> -  0) **Acknowledge:**
> -    - A non-automated response email is sent to the reporter(s) to acknowledge
> -      the reception of the report. (*60 day's counter starts here*)
> -
> -  1) **Triage:**
> -    - Examine the issue details and confirm whether the issue is genuine
> -    - Validate if it can be misused for malicious purposes
> -    - Determine its worst case impact and severity
> -      [Low/Moderate/Important/Critical]
> -
> -  2) **Response:**
> -    - Negotiate embargo timeline (if required, depending on severity)
> -    - Request a [CVE](https://cveform.mitre.org/) and open an upstream
> -      [bug](https://www.qemu.org/contribute/report-a-bug/)
> -    - Create an upstream fix patch annotated with
> -        - CVE-ID
> -        - Link to an upstream bugzilla
> -        - Reported-by, Tested-by etc. tags
> -    - Once the patch is merged, close the upstream bug with a link to the
> -      commit
> -        - Fixed in: <commit hash/link>
> -
> -* Above security lists are operated by select analysts, maintainers and/or
> -  representatives from downstream communities.
> -
> -* List members follow a **responsible disclosure** policy. Any non-public
> -  information you share about security issues, is kept confidential within
> -  members of the QEMU security team and a minimal supporting staff in their
> -  affiliated companies. Such information will not be disclosed to third party
> -  organisations/individuals without prior permission from the reporter(s).
> -
> -* We aim to process security issues within maximum of **60 days**. That is not
> -  to say that issues will remain private for 60 days, nope. After the triaging
> -  step above
> -    - If severity of the issue is sufficiently low, an upstream public bug
> -      will be created immediately.
> -    - If severity of the issue requires co-ordinated disclosure at a future
> -      date, then the embargo process below is followed, and upstream bug will
> -      be opened at the end of the embargo period.
> -
> -  This will allow upstream contributors to create, test and track fix patch(es).
> -
> -### Publication embargo
> -
> -* If a security issue is reported that is not already public and its severity
> -  requires coordinated disclosure, then an embargo date will be set and
> -  communicated to the reporter(s).
> -
> -* Embargo periods will be negotiated by mutual agreement between reporter(s),
> -  members of the security list and other relevant parties to the problem.
> -  The preferred embargo period is upto [2
> -  weeks](https://oss-security.openwall.org/wiki/mailing-lists/distros).
> -  However, longer embargoes may be negotiated if the severity of the issue
> -  requires it.
> -
> -* Members of the security list agree not to publicly disclose any details of
> -  an embargoed security issue until its embargo date expires.
> -
> -### CVE allocation
> -
> -Each security issue is assigned a [CVE](https://cveform.mitre.org/) number.
> -The CVE number is allocated by one of the vendor security engineers on the
> -security list.
> -
> -## When to contact the QEMU Security List
> -
> -You should contact the Security List if:
> -* You think there may be a security vulnerability in QEMU.
> -* You are unsure about how a known vulnerability affects QEMU.
> -* You can contact us in English. We are unable to respond in other languages.
> -
> -## When *not* to contact the QEMU Security List
> -* You have not yet performed human review of the output of an automated tool.
> -* You need assistance in a language other than English.
> -* You require technical assistance (for example, "how do I configure QEMU?").
> -* You need help upgrading QEMU due to security alerts.
> -* Your issue is not security related.
> -
> -## How impact and severity of a bug is decided
> -
> -**Security criterion:**
> -    -> [https://www.qemu.org/docs/master/system/security.html](https://www.qemu.org/docs/master/system/security.html)
> -
> -All security issues in QEMU are not equal. Based on the parts of the QEMU
> -sources wherein the bug is found, its impact and severity could vary.
> -
> -In particular, QEMU is used in many different scenarios; some of them assume
> -that the guest is trusted, some of them don't. General considerations to triage
> -QEMU issues and decide whether a configuration is security sensitive include:
> -
> -* Is there any feasible way for a malicious party to exploit this flaw and
> -  cause real damage? (e.g. from a guest or via downloadable images)
> -* Does the flaw require access to the management interface? Would the
> -  management interface be accessible in the scenario where the flaw could cause
> -  real damage?
> -* Is QEMU used in conjunction with a hypervisor (as opposed to TCG binary
> -  translation)?
> -* Is QEMU used to offer virtualised production services, as opposed to usage
> -  as a development platform?
> -
> -Whenever some or all of these questions have negative answers, what appears to
> -be a major security flaw might be considered of low severity because it could
> -only be exercised in use cases where QEMU and everything interacting with it is
> -trusted.
> -
> -For example, consider upstream commit [9201bb9 "sdhci.c: Limit the maximum
> -block size"](https://gitlab.com/qemu-project/qemu/-/commit/9201bb9), an of out of
> -bounds (OOB) memory access (ie. buffer overflow) issue that was found and fixed
> -in the SD Host Controller emulation (hw/sd/sdhci.c).
> -
> -On the surface, this bug appears to be a genuine security flaw, with potentially
> -severe implications. But digging further down, there are only two ways to use
> -SD Host Controller emulation, one is via 'sdhci-pci' interface and the other
> -is via 'generic-sdhci' interface.
> -
> -Of these two, the 'sdhci-pci' interface had actually been disabled by default
> -in the upstream QEMU releases (commit [1910913 "sdhci: Make device "sdhci-pci"
> -unavailable with -device"](https://gitlab.com/qemu-project/qemu/-/commit/1910913)
> -at the time the flaw was reported; therefore, guests could not possibly use
> -'sdhci-pci' for any purpose.
> -
> -The 'generic-sdhci' interface, instead, had only one user in 'Xilinx Zynq
> -Baseboard emulation' (hw/arm/xilinx_zynq.c). Xilinx Zynq is a programmable
> -systems on chip (SoC) device. While QEMU does emulate this device, in practice
> -it is used to facilitate cross-platform developmental efforts, i.e. QEMU is
> -used to write programs for the SoC device. In such developer environments, it
> -is generally assumed that the guest is trusted.
> -
> -And thus, this buffer overflow turned out to be a security non-issue.
> +## How to disclosure potential issues
> +
> +**The QEMU project no longer accepts security issue disclosures via email.**
> +
> +New disclosures must follow the [report a bug](report-a-bug.html)
> +process to file a GitLab issue (work item) for each potential issue,
> +***marking it as "*confidential*" prior to submission.***
> +
> +Some important notes when disclosing potential security issues:
> +
> +* The QEMU project cannot provide an SLA for response to security
> +  disclosures, or any bug reports in general. Issues will be
> +  responded to at the discretion of maintainers, subject to their
> +  available time.
> +
> +* Attachments added to GitLab *confidential* issues are not themselves
> +  confidential. If someone knows the randomly generated URL for the
> +  attachment, they can view the content. Thus be careful where attachment
> +  URLs are shared, while the issue remains confidential.
> +
> +* All disclosures will eventually be made public. Thus the content
> +  or attachments for any issue must not contain data that the reporter
> +  considers to be sensitive / private.
> +
> +* Not all areas of QEMU are considered to provide a security
> +  boundary. Consult the [security guide](https://www.qemu.org/docs/master/system/security.html)
> +  for details on how QEMU classifies features.
> +
> +* If an issue affects a feature within the QEMU security boundary,
> +  but the reporter is unsure of the security implications, err on
> +  the side of caution and mark it as "*confidential*" initially.
> +
> +* All important information must be disclosed in the issue description,
> +  minimizing use of attachments to what is strictly needed. There is
> +  a strong preference for individual files to be attached directly.
> +  Avoid the use of archives (zip, tar, 7z, etc) to bundle files where
> +  practical.
> +
> +## Handling of disclosures
> +
> +Disclosures made via "*confidential*" GitLab issues are visible to, and
> +may be handled by, any QEMU subsystem maintainer with a GitLab account
> +[associated with the Reporter role in the project](https://gitlab.com/qemu-project/qemu/-/project_members).
> +Triage may also be performed by one or more automated tools and/or
> +AI agents run by the project that have been granted access to the
> +issue tracker.
> +
> +The first task for maintainers upon receiving a disclosure is to evaluate
> +eligibility to follow the security triage process.
> +
> +* Disclosures affecting code / features evaluated to fall under the
> +[non-virtualization use case](
> +https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case),
> +will generally not be eligible for handling as a security flaw.
> +Such disclosures should be immediately switched to the public
> +bug report process by removing the "*confidential*" marker.
> +
> +* Disclosures affecting code / features evaluated to fall under the
> +[virtualization use case](
> +https://www.qemu.org/docs/master/system/security.html#virtualization-use-case),
> +will be handled under a lightweight security triage process which
> +emphasizes getting a fix merged to the latest development branch
> +as quickly as possible.
> +
> +In all cases reporters are encouraged to develop and propose patches
> +for issues themselves at time of disclosure, to speed resolution.
> +
> +**NOTE:** The QEMU project policy is that all security disclosures received
> +using GitLab "*confidential*" issues **will eventually be made public**. Any
> +information that the reporter considers to be be sensitive / private **must**
> +be scrubbed before disclosure.
> +
> +## Triage process
> +
> + * A maintainer will evaluate the circumstances of the issue
> +   to determine if it can be misused for malicious purposes.
> +
> + * If there is no potential for meaningful exploit, the disclosure
> +   should be switched to the public bug report process by removing
> +   the "*confidential*" marker and adding the **"Kind::Bug"** and
> +   **"Workflow::Triaged"** labels.
> +
> + * If confirmed as a security flaw, a maintainer will add the
> +   **"Kind::Security"**, **"Workflow::Confirmed"** and
> +   **"CVE::Required"** labels.. The latter indicates the need
> +   for a CNA to allocate a CVE.
> +
> + * The maintainer(s) will develop and/or review patch(es)
> +   for the issue privately, optionally attaching work in
> +   progress fixes to the GitLab issues. All patches must
> +   include the issue URL in the commit message(s). The
> +   **"Workflow::In Progress"** label should be assigned when
> +   a maintainer starts working on a fix.
> +
> + * When a CVE is allocated, it must be recorded as a comment on
> +   the GitLab issue, and the **"CVE::Required"** label replaced by
> +   the **"CVE::Assigned"** label.
> +
> + * The maintainer(s) will update the commit message(s) to include
> +   the assigned CVE and issue URL. If multiple commits are required
> +   to fix an issue the CVE must be included in the final commit in
> +   the series, and may optionally be included in all prior commits.
> +
> + * When the maintainer(s) are satisfied that the patch(es) are
> +   suitable to propose for merge, they must be submitted to
> +   the qemu-devel mailing list, and follow the normal process
> +   for merge henceforth. The **"Workflow::Patch Available"**
> +   label should be assigned at this stage.
> +
> + * At the time the proposed patches are sent to qemu-devel, the
> +   maintainers should remove the "*confidential*" marker from the
> +   GitLab issue.
> +
> + * When the patch is merged into the current development
> +   branch the issue must be closed. This should usually happen
> +   automatically if the git commits referenced the GitLab issue
> +   URL in [the normal format](https://docs.gitlab.com/user/project/issues/managing_issues/#default-closing-pattern).
> +   The **"Closed::Fixed"** label can be assigned.
> +
> +The QEMU project currently co-ordinates with Red Hat Product
> +Security for CVE assignment, in its role as the [CNA of last
> +resort for OSS projects](https://www.cve.org/PartnerInformation/ListofPartners/partner/redhat).
> +
> +## Embargo policy
> +
> +The QEMU project policy is to limit the time that a disclosure has the
> +"*confidential*" marker applied strictly to the minimum required to develop
> +and publish a suitable patch and allocate a CVE.
> +
> +Given the widespread use of AI/LLM based agents for security auditing,
> +as well as ongoing use of traditional fuzzing and static analysis
> +tools, the QEMU maintainers consider that any disclosure originating
> +from automated tools is highly likely to be independently re-discovered,
> +potentially many times over in a very short timeframe.
> +
> +Thus the QEMU maintainers will generally reject requests for arbitrary
> +embargoes unless high severity, extenuating circumstances can be
> +demonstrated.
> +
> +If a patch for a confirmed security issue cannot be developed by a
> +maintainer in a reasonable time, the maintainers may choose to make
> +a disclosure public without having a patch available. This approach
> +should only be taken for issues judged to have low severity.
> -- 
> 2.54.0


