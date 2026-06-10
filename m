Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545BFCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXE5C-0007wC-2W; Wed, 10 Jun 2026 04:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXE5A-0007vh-5Z
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXE58-000865-52
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781079276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DV/gVqvojX/J4FAgq/MiN7Jl8LpF/YpdzXd9IcwPnTs=;
 b=cLoTgE+I/zlHZfvK7EaKI6XnaEqiYNTnfJJcPoaPBIEP0/vayiAqHo8Gw+NugV1C2+0C8w
 kouoo83guGkjEwAJ6wZlSWQ3WjIb8hvu2tirs93rP5pBUonFgBTvrWkoYqKJnxXF68nULM
 X6CmCqn4WjM134k5Owwxs8nVDrKyGws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-LJ0WRs89PHm5pxBkKfqTFA-1; Wed, 10 Jun 2026 04:14:34 -0400
X-MC-Unique: LJ0WRs89PHm5pxBkKfqTFA-1
X-Mimecast-MFC-AGG-ID: LJ0WRs89PHm5pxBkKfqTFA_1781079273
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490bfd70b0fso65053025e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781079273; x=1781684073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DV/gVqvojX/J4FAgq/MiN7Jl8LpF/YpdzXd9IcwPnTs=;
 b=i++fUPGSCNE1Paf1B9CPSzvvs0c8nAG3v4rN70B/r2JKszt3r+7e/0O+lydRGnpg1W
 9t3sjdl7VsBrnGMndJJElrB9FcR1VreRwkN0tFynpAIq359+wPk7sjlVFvsCMpWPE2I9
 JgqIb9KxuX3rFJqALSIBAdv28OAqtucbXMR95Im6fMqJAwjnRxC2UboIc3jPywErDleP
 39TU+BdLxnmoPfh0v+lc2RL9UeBgOFBMFIfS2TQg/DldFVEF3pq0VBVMYYBnc2dX+Wod
 Cl27jzzz8r+unf9J0qit8HpyB43AExNu/EHBG/a7NFUoERdBEHBMitdNoolE0adhLgFt
 rPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781079273; x=1781684073;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DV/gVqvojX/J4FAgq/MiN7Jl8LpF/YpdzXd9IcwPnTs=;
 b=L4sjr9y5KvJXRy+TMTPePhhtgJy2i0m0f4rTCAIP6w0uEaV/Ckq+rv2+JOw8Kw8kFy
 PunJM8VASC0vo3p6ETwUO09j6X+qP9UJN1B0mij6zVYiRNYNQ+ohITwAbp3sG0IiSrxQ
 aVS0MOaNzF/FMyT2IBlbrWlIhGXgUvY/6m4Y85ByZJp1jRyjUwzpoTb/XZk58Wa1JyqK
 sK8yynnMguZ2ENBTaxaF1sQiqKLuHTURCBmoKUc5e0lOxiO4pc3HskMVRmCFG/BOQsHe
 3bw6c4M/2DVO+1AZlRzSyGGUYEWYwWUwNPSC1ic8avoMyxtQJrCYM4IKCMQWhGrmGhMV
 yynQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9C5uxrPsRIRn+FNcN4WC0dUTvaRffHmBnLmMDxig/di033cHOCFFcRCys5DqdJgluq5aHUY6FF22vn@nongnu.org
X-Gm-Message-State: AOJu0Yy6cM6CGAZlLUWzE1fgnyee3DgQlteJiXgAR5ImHRQG+XnNYDen
 HDwz9bKGwNS6mJWmGv4hF9tcGMMXFWVmfW5AJDKdqjEvoQTB1N/3HJA/lSxn1FPUL5pIowf5YaG
 AxytHrOTtYj/B1fBlH9ulJFx1VBmTLaFNfxjV9sTig+5pL0lKQ/jtBL+t
X-Gm-Gg: Acq92OHSPsHPz/od8Z9Zm/06dHj/txAMDLGvzmRe+ArXu6B6TLcLZO7yM99bl2uZwCP
 eBrZV4KLnHz+akRnjll97BzL1uFreYszlQFfqBst/Yrz1/Z7ArCEZnjy3lojz0himjfNxNHajPk
 RE68brg880xq0As0KbEefBABwQDRaRP0/i7F1SdJDBnH1EMh7D91zQ1kXg/dcQ3gMhMaAoj7Xz1
 05eFYr4GRpWUeUSDjstMX3TolNImW3I9z5aHb40gPjqzhfALIXTxSl3uauVycKiUW1OcuRdLXoh
 PASxqGurr2jTUyo/Qy9Iena8aJTVhl5nkzKYCmOXFr9CQI5Er+Mcfdsny0VJkwOiWRGcmQ4elPP
 6ebT5Ub/hBN714aEVTnoJBTE3alPIdA==
X-Received: by 2002:a05:600c:3ba1:b0:490:b072:1be6 with SMTP id
 5b1f17b1804b1-490c2633778mr407406485e9.25.1781079273073; 
 Wed, 10 Jun 2026 01:14:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba1:b0:490:b072:1be6 with SMTP id
 5b1f17b1804b1-490c2633778mr407406125e9.25.1781079272664; 
 Wed, 10 Jun 2026 01:14:32 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm653483435e9.9.2026.06.10.01.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 01:14:31 -0700 (PDT)
Message-ID: <32ace8d5-0f61-4fd6-b2f9-6b2b67216d64@redhat.com>
Date: Wed, 10 Jun 2026 10:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260604165048.457860-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/06/2026 18.50, Daniel P. Berrangé wrote:
> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
> 
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.

Slightly off-topic question ... but: Should we require all maintainers to 
have a gitlab account now? Otherwise we might end up with confidential 
issues nobody is looking at since the related maintainer does not have a 
gitlab account and the other maintainers don't care?

...
> +## How to disclosure a potential issues
> +
> +**The QEMU project no longer accepts security issue disclosures via email.**
> +
> +New disclosures must follow the [report a bug](report-a-bug.html)
> +process to file a GitLab work item for each potential issue, ***marking
> +it as "*confidential*" prior to submission.***
> +
> +If unsure of the security implications of an issue, err on the side
> +of caution and mark it as "*confidential*" initially.
> +
> +## Handling of disclosures
> +
> +Disclosures made via "*confidential*" GitLab issues are visible to, and
> +may be handled by, any QEMU subsystem maintainer whom has a GitLab

I am not a native speaker, but my (likely wrong) gut feeling say it should 
be "who" instead of "whom" here?

> +account [associated with the Reporter role in the project](https://gitlab.com/qemu-project/qemu/-/project_members).
> +Triage may also be performed by one or more automated tools and/or
> +AI agents run by the project that have been granted access to the
> +issue tracker.
> +
> +The first task upon receiving a disclosure is to evaluate eligibility
> +to follow the security triage process.
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
> +Any disclosure which gets switched to the public bug report process
> +will be fixed at the discretion of the maintainer, if and when time
> +allows.
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
> +   the "*confidential*" marker.
> +
> + * If confirmed as a security flaw, a maintainer will request
> +   add the **"cve::required"** GitLab label to the GitLab work item,
> +   which indicates the need for a CNA to allocate a CVE.
> +
> + * The maintainer(s) will develop and/or review patch(es)
> +   for the issue privately, optionally attaching work in
> +   progress fixes to the GitLab issues. All patches must
> +   include the issue URL in the commit message(s).
> +
> + * When a CVE is allocated, it will be recorded as a comment on
> +   the GitLab issue, and the **"cve::requested"** label replaced by
> +   the **"cve::assigned"** label.
> +
> + * The maintainer(s) will update the commit message(s) to include
> +   the assigned CVE. If multiple commits are required to fix an
> +   issue the CVE must be included in the final commit in the
> +   series, and may optionally be included in all prior commits.
> +
> + * When the maintainer(s) are satisfied that the patch(es) are
> +   suitable to propose for merge, they must be submitted to
> +   the qemu-devel mailing list, and follow the normal process
> +   for merge henceforth.
> +
> + * At the time the proposed patches are sent to qemu-devel, the
> +   maintainers should remove the "*confidential*" marker from the
> +   GitLab issue.
> +
> + * When the patch is merged into the current development
> +   branch the issue must be closed. This should usually happen
> +   automatically if the git commits referenced the GitLab issue
> +   URL in [the normal format](https://docs.gitlab.com/user/project/issues/managing_issues/#default-closing-pattern).
> +
> +The QEMU project currently co-ordinates with Red Hat for CVE
> +assignment, in its role as the [CNA of last resort for OSS projects](
> +https://www.cve.org/PartnerInformation/ListofPartners/partner/redhat).
> +
> +## Embargo policy
> +
> +The QEMU project policy is to limit the time that a disclosure has the
> +"*confidential*" marker applied strictly to the minimum required to develop
> +and publish a suitable patch and allocate a CVE.
> +
> +Given the widespread use of AI/LLM based agents for security auditing,
> +as well as ongoing use of traditional fuzzing and static analyis

s/analyis/analysis/

> +tools, the QEMU maintainers consider that any disclosure originating
> +from automated tools is highly likely to be independently re-discovered,
> +potentially many times over in a very short timeframe.
> +
> +Thus the QEMU maintainers will generally reject requests for arbitrary
> +embargos unless high severity, extenuating circumstances can be

s/embargos/embargoes/

> +demonstrated.
> +
> +If a patch for a confirmed security issue cannot be developed by a
> +maintainer in a reasonable time, the maintainers may choose to make
> +a disclosure public without having a patch available. This approach
> +should only be taken for issues judged to have low severity.

  Thomas


