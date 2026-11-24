Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A5606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UtkF0bLG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxlg-0005v8-He; Tue, 24 Nov 2026 16:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxlV-0005uh-9U
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:09:25 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxlT-0001rm-IQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:09:24 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67db35e7953so5207812d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554561; cv=none;
 d=google.com; s=arc-20260327;
 b=jENJh1ECquij3sK/oPNKi3j++ht1CY2QnJW42l47Jzszprruu5fpihqDwuvlTJaq8q
 JHENGO8uahe2Sdgsfdyizhs9oecqy+8dO5Lmf5dagdo15+LNsvIU0aoTHrx+K7LSYWmT
 PyHkfjgrA15s4jIza9kb5Nnau5rji6S/apoQ1IoyCd/fTWnBLUUK/gt17szpUuZFGPP3
 T6uPRboTGhdXejRhVzSgmG5gDqGJcg7GmShn3uGqHs8Jql8GplZLou7gZGZMS2YqSw08
 NxzGV0mbTD5vlAXN2+ohpSeRHAg+lKzP+YI0qMyy4NQs2t3FDgix/xWLFVjdfORFMOSR
 +qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xP8PKm9AsvLxmT/MIwLYqwtYLALtFvIEnLRnahC1dmI=;
 fh=0Y1ceun9IAqu26AKCJYiucrdOmjrtmNyyg87OCZ4kjk=;
 b=a8c77ppv3RauMEXMZd+PSgKcv1yXIZmICdvkM0P2rtXCRIogvUC1N8eQTeFUgWwBc4
 LhS/ZAr8AqEUhdtveyc+k8yvbqBqK5F2Md731jSYYdY5M6jpePhGWf6Z3OF2oZQIPC1C
 t8YUAj+6h+vLn9TQn0rm3dFsuONwj1etSpvy0WDJ/1fZgC7VKxc87vgAZPzR0OLQ1zKq
 AdrD3ibBSURakK67JbYbW9npqbxCvwPNoJfVyaHWrBCiGQG7uJo7K2+oZGeHQYNQpDS9
 zLlLLAs2VqciHqZbNQSCiiialewApPtGPdEPEanRJDPOQ3QYG/FJXPqG95Drb2Tbh2Tv
 oPCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795554561; x=1796159361; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xP8PKm9AsvLxmT/MIwLYqwtYLALtFvIEnLRnahC1dmI=;
 b=UtkF0bLGIrPw+16WfnvZTcs3H7zIVgQza4rpmP/0TNlfK4+mCvm3VKR6lkccmdR034
 P1b/m0MkAXI/eP+e2Seq/ijxBHYn22BSu9g5lDekKm9u53fb+jLbx3yAmS2i4MiubJ+v
 OEbIEwwcnrFFlXzdDDTqFUt4wukmrl1Kvx7Nid9OqcF2PJbv0Ie6XHFRYZhg8gxf16KV
 7IUOmbrDi1LEsEBlzB8i9FMzJWkJq1b47hcNWihCn9WW5h7ZoaqQBYaB6mFyDpoMfGJb
 F0lWyzoKfs5KVxwRmSHVoDKo6oJqfvw5BZVzpPXTEzXMkfc1H8t8VXDPuNUwuBktbeeA
 xKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795554561; x=1796159361;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xP8PKm9AsvLxmT/MIwLYqwtYLALtFvIEnLRnahC1dmI=;
 b=KxG/+FZ3Zrxi3s5nfmDtJ91nycU6qhFxcRwacjYEmJvt/rUpLxhOuLMwn1c+RkWwC1
 B/XTsWRzIcROSXmsSYEM4iGJ4Q1SZBDNuRL/1Ea1ZsriMPvqkKm8dTAW05tJ0FVRJpjT
 9UeeY9NHIwaW9K/QpZLqi0PjT/x+s/Kh7O/I5b/7m6B7WNHTehAYmlWj3Fd9mWb2t4qy
 JAQDi1l1pygxzoAu7qtXuFgbYAOqkzbyt+7mRIoFjRCzExdKL2WXzvmQn5sQ00JbzBK9
 i1U2obZCZLPFpKotzTcQTDEtoL9355FYY/Pc9z+4gOorDiqN8d5J2HE3AQZYeIFLw7aS
 rFiQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGOvUnTVhLBQmKjPUWzMz7rbdJWJKob2Th0GjVCPuLE0rgyrJFrb7R0i8WqZKKujcvKb3WSzFbisiFY@nongnu.org
X-Gm-Message-State: APuU4Z+9MMJqUpRJjtylpjj2UUzx/QiJkkT63+mD8njdwBSgJcJMk5+7
 32hoV9c0znj2ahKAbdIKIHHNl9g5prV+byPQNAcrtlgiRrhwhelpyAFuU/cZRcR7xrIR2TRisbA
 lntLv4UGZ4v9hcmpQ7goQR0glcmakyVPBOOaDxeiPxA==
X-Gm-Gg: AZFdTZcUU+yvPZAKpkVaFqOx6oYFr6k1ucVl/xRd2KBpHABNiLLD0TI3Kc8CuQo/hvc
 2YzblHyK62L5z9gi+VF4cfJ0soIDkY8bBbm2T1fdskvTZ1GQKUzOqTccIx84qBq9dA+989OTmb9
 hkv9IW5QdUa70CZiViyrXrfSMGvffuHENa4F5NXLsw7rxDzHzDfayr7kVNT/mZevFlZwF0c5C79
 Pt+6ZF78CLGL1QoLP0fLFueiCOn7eVvIPZbWYEdBn345BrFqa3gbXkoL2opLWxLB5ht4VPza85r
 VpqHXpMuOx1hByZtkxMM+DXlVC/NktjjVOXAoVImZ3dqB4Yemii1tP0AP8Szh5fCdaXojDj1SQd
 ej8C+bIKG9Xr4x/9MaSSZutVu2gsENj65zsEKr+t0a3HII0tPROFayEEyJWohu4jo22bSzAQa2F
 T7pXR4xPD68RLVT0y2l3EIGw==
X-Received: by 2002:a05:690e:150b:b0:67d:a7fe:a8f0 with SMTP id
 956f58d0204a3-67df455cbbbmr4968175d50.108.1795554560543; Tue, 24 Nov 2026
 13:09:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 21:09:07 +0000
X-Gm-Features: Aa3M54prDMc-Dh6GqJQLadvY_KHSNXRs4ufP9n4sDlS3WIZUUUi0JAyaRak0k0k
Message-ID: <CAFEAcA_WhhhPudTRhCv8WW8=w_ZutWFKKyT=PRaCA4-Q3bVdwQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, 
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 21:05, Peter Xu <peterx@redhat.com> wrote:
> OTOH, to me it'll be very helpful if we could provide what we want exactly
> in cover letters and commit logs into AGENTS.md.  It can be either pure
> formats, styles of expressions, best practices of comments, etc.  But
> actually I'm not sure either, because IIUC very new models are getting rid
> of skills people wrote and can do sometimes even better with shorter prompt
> than complex + long prompts, so maybe we really only want to add the most
> important prompts when we really want to do so.

What I want from a cover letter and commit message is the *human*
intent behind the change. I don't want a robot's summary of the
code changes. This to me is connected to the older idea of
"explain why, not what" for commit messages and comments.

-- PMM

