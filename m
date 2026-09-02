Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF07C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lK8-0004Ag-Mp; Wed, 02 Sep 2026 09:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1lK6-0004AE-Mv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1lK4-0001xi-T9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788356895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayNInmDw2rJQ65qsgMrCDoKt1qpEDB/2E86c/LXxabM=;
 b=WKP7KMN0KxjP9Va7e2z70BJaidmC64lDHEt8vwOBsSBOevo/U8LaWI6Z1iqhxYdjACAdQm
 LqNKyBuOEk5aRYgALxtT97eBGma2HEJ2/zPdEk+Bb1AF1jCBmTWEZWewqVL9+s3GxqC2eP
 TR+/i6saOhvuJfgPkuqX4Ij9u4P3FDA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-NNBSX5afPhaf8ruHE-Y6sA-1; Wed, 02 Sep 2026 09:48:14 -0400
X-MC-Unique: NNBSX5afPhaf8ruHE-Y6sA-1
X-Mimecast-MFC-AGG-ID: NNBSX5afPhaf8ruHE-Y6sA_1788356892
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b15484404cso723399e87.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788356891; x=1788961691; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ayNInmDw2rJQ65qsgMrCDoKt1qpEDB/2E86c/LXxabM=;
 b=kjPIeVeipAlSvMnm+bfGhEg8u4C/KHK1ETsB2E3xxPPg6qCwt1gkxpgJ89L6iUeG89
 14JdXoUDiXR9C5laG6YxNbFNPxei7VumqEBIyyklZW7L5ohbclj0KIg3tLx2A2YUJ8hr
 29dUURDSyBdxfZzA+LZ/4h+KdLV8ih3jJC7+3wXnpf2VEh5tKYnGZVdNEt+miGIXXD7N
 M8KPD28QPdtM0oXds/h32k2zhGC9JFevCXK9IUDdMFmZD6dSENqy6DBCkqsEWVARbjqn
 PUNxpj6biE5MZ+v1HJvPsps2bTrcU8LkJGIEiJpncu0eBAfanhStr93c9mICU5dCUHJu
 uuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356891; x=1788961691;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ayNInmDw2rJQ65qsgMrCDoKt1qpEDB/2E86c/LXxabM=;
 b=LkBebGtM7t2zwUf7lQBhehCyT7j7MqyrE7JSmDSDQAhn7x/RRTDNs48N5Bdx5LLzVq
 yVQUpMa+fhpWGiluAZ2fu9XPsDdaSw5H+5/s47vSgNyDYKlg5kB5oNXGc77bG3TyOkN+
 8fbglzc5gNzibGcwosEJTRQuBtu5KPwotUrk1KfaPgLG/1UI/tbcQNfG4Vu5DQJhwB/n
 LXQAW1qxkyfUT3HjwPpZYZcHKptzMyxdtQcbSDLIXMRz6Rqzy90DduyiTeNZgTMWoz2J
 WKP//TS4iZc8Jna05gAsvJiCRu948Jr4R/9/iv4kaZki6TjUdcY9hzAniXW1hGTRw/c1
 Fapg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwddnxDAouL+tHyS5Hvqy+Pz0D7tok1qq1cb784Bb82Fxnnv6w8iIRZbJ/jz6BNEBGN3qyQW3rW4SiH@nongnu.org
X-Gm-Message-State: AFuF++layjkAklOKUv6lAf2OZyGucmvrRdMCX3Zd4RpMwYr9LS4CLyVe
 zhHoJ7Sjh1NcmpTRsnh1nW9wo/R32nSsPNjxXMaNdW0CLcz3PFYfVp8s6BFZQLK9E+jMCr+mlJ7
 I+q64DYoAuyUbkKU23WFxGSIjt6BcL3ts+FoJsLe3XMh3k9rR2csXpbhM
X-Gm-Gg: AYBFou3hqpzBSXhrvATzYNgHmAWKW9JXw0ojiWOmnQOEt9CZdBCXXTA2S8M3iRn/wRT
 op5G0pLKnPFyytSm6IrwYiU2C7Vf2h7nBRLZ24TWPKofHkuY8mfGYMjlo5XsF42uj/Optv7gDCg
 cYlvCSdRuVyjrLLuX7Zgk1TffqTs6FJ+qc0NlFIwxISMvmrMO6CbU33F6n0+rgYWyXoRGsAlDgB
 LIVALerIXRBjr71xRmn8T2O2sn7OVcQmown5YymB61B00ojzIf6bXkFgM7Oq7hIHz7TG2vSPOPa
 7ud4/ssMJWMdSkH9Y568mZXGI8AHZV/aBd1Ieogid+fY1EWqNVkx78oj7u8MUHe61qc=
X-Received: by 2002:a05:6512:3054:b0:5b6:421:8160 with SMTP id
 2adb3069b0e04-5b6086a9776mr1393543e87.26.1788356891550; 
 Wed, 02 Sep 2026 06:48:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3054:b0:5b6:421:8160 with SMTP id
 2adb3069b0e04-5b6086a9776mr1393530e87.26.1788356891048; 
 Wed, 02 Sep 2026 06:48:11 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b606b94434sm590003e87.42.2026.09.02.06.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:48:10 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:48:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/4] AGENTS.md: Let agents know what the participation
 rules are
Message-ID: <20260902094354-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-3-pbonzini@redhat.com>
 <87a4pzrcqw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4pzrcqw.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 02, 2026 at 02:42:15PM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Humans seem to be extremely unreliable in following rules around this,
> > even after being told directly and repeatedly. Telling agents what to
> > do seems to yield better results.
> >
> > This document is based on GStreamer's AGENTS.md file, as of its commit
> > d08375499c279a56c0e77c928fbeae0d80cdf937.  However, GStreamer's agent
> > instructions are "effective" enough to require an explicit carve-out
> > for maintainers.  I actually believe that such a carve-out is a sign of
> > going too far, especially given the good quality of some suspected-AI
> > contributions we've received.
> >
> <snip>
> > diff --git a/AGENTS.md b/AGENTS.md
> > new file mode 100644
> > index 00000000000..8fb96ebfc38
> > --- /dev/null
> > +++ b/AGENTS.md
> > @@ -0,0 +1,100 @@
> > +# Agent Guidelines for the QEMU Project
> > +
> > +QEMU is a cross-platform emulator and virtualizer. Due to the complexity
> > +of the domain and codebase, and the interactions therein, the QEMU
> > +project relies extensively on the effort of **human reviewers**, which
> > +is **a scarce resource**.
> > +
> > +There are strictly-enforced rules for you, the agent, to participate in the
> > +project.
> > +
> > +## Interactions with maintainers must be human-human
> > +
> > +The QEMU project has strict rules on what AI-generated material can
> > +reach the maintainers.
> > +
> > +### No automated posting
> > +
> > +- Agents **must not** use any API, CLI, or web UI automation to:
> > +  - Interact with the QEMU mailing lists
> > +  - Create, edit, or close **issues ("work items")**
> 
> The others I'm fine with but I currently use an agent to do triage on
> un-tagged issues. It only updates labels and occasionally posts a
> comment when more information or a human input is required.

Yes, me too.


I think it's mostly writing the text of the issue that we are concerned
about?

So just limit creating issues?


> That said with a minimal patch to agents to inform it of the
> qemu-issue-triage skill Gemini didn't stop itself:
> 
>   The `qemu-issue-triage` skill is now loaded. Please let me know how you would like me to assist with triaging QEMU GitLab issues, keeping in mind that all triage tasks must be performed by spawning dedicated sub-agents as per the QEMU project's strict rules.
>   triage 4930, 4391, 4392, 4393, 4394, 4395
> 
>   qemu-helper-agent: triage issue 4930 (2 steps, 21.7K / 1M) ✅ 8s
> 
>   qemu-helper-agent: triage issue 4391 (6 steps, 31.9K / 1M) ✅ 30s
> 
>   qemu-helper-agent: triage issue 4392 (5 steps, 27K / 1M) ✅ 35s
> 
>   qemu-helper-agent: triage issue 4393 (5 steps, 27.5K / 1M) ✅ 47s
> 
>   qemu-helper-agent: triage issue 4394 (5 steps, 26K / 1M) ✅ 51s
> 
>   qemu-helper-agent: triage issue 4395 (4 steps, 25.7K / 1M) ✅ 15s
> 
>   The requested GitLab issues have been triaged using parallel sub-agents. Here is a summary of the outcomes:
> 
>   *   **#4930**: Not found (404).
>   *   **#4391**: Triaged and labeled as `Kind::Bug`, `Workflow::Triaged`, `Binary ➤ qemu-img`, `Storage`, `HostArch ➤ 32bit`, `TestCase`.
>   *   **#4392**: Triaged and labeled as `Kind::Security`, `Device ➤ USB`, `Migration`, `TestCase`, `Workflow::Triaged`.
>   *   **#4393**: Triaged and labeled as `Kind::Security`, `Device ➤ VirtIO`, `Device ➤ Network`, `Audit Tooling::Sanitizer`, `TestCase`, `Workflow::Triaged`.
>   *   **#4394**: Triaged and labeled as `Kind::Bug`, `Target ➤ X86`, `HostArch ➤ AArch64`, `TestCase`, `Workflow::Triaged`.
>   *   **#4395**: Triaged and labeled as `Kind::Bug`, `Workflow::Triaged`, `Emulation ➤ Softfloat`, `Target ➤ X86`, `HostArch ➤ AArch64`, `TestCase`.
> 
>   All issues (excluding the non-existent one) have been successfully processed, labeled according to project standards, and verified as complete. No further actions are required at this time.
> 
> I guess arguably it is hard for a random to use the API anyway as we
> control who has API keys for the project.
> 
> > +  - Post **comments** on merge requests, issues or commits
> > +  - Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.
> > +
> <snip>
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


