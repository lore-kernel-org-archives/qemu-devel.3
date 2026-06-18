Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E230CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waF28-0003UU-NJ; Thu, 18 Jun 2026 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waF27-0003TZ-ET
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waF25-00051l-P7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781797916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xMuczNx1Y2CV0a6BY4byz1kAAhc+cFwhJZZw4ObJmzM=;
 b=YDUTLR46M2a35UP45ZylynuP0dtbXNMjBgW3gGnjEPY/Qj82Z2ZAGstov2DzWfnddaGQDB
 MPCW5iZbiw+WaW8g3xNffTW5GRi5l0Cenw+YdLPWyhKVVOWcAsffp08g7QaSbxb1vLqSZL
 O+zM7jl13cohzL6OWV9jFugnPXkhEWU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-UWOOHgcGP7-QoFewGbIIXw-1; Thu, 18 Jun 2026 11:51:55 -0400
X-MC-Unique: UWOOHgcGP7-QoFewGbIIXw-1
X-Mimecast-MFC-AGG-ID: UWOOHgcGP7-QoFewGbIIXw_1781797914
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef616db45so1107054f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781797914; x=1782402714; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xMuczNx1Y2CV0a6BY4byz1kAAhc+cFwhJZZw4ObJmzM=;
 b=X4hh/4QPvHX+43Kr2uGF3j/C7fMaNKim8Rn/Jxy1pT85+xUSRLXQqcpbA/SjOyBXHk
 WxZWmqVhAdpB43Xg/ZwuvZjkZTUyYdReRo3jeSzIc6SrnIvtdtP8AWsSBoPuteU6zi0n
 HW0a6vYHrVugGPRGB99/z57ZpYo6vhNx4FLC/D6nm9QejpodP87p/73+EgHkn3ZxmgXo
 HCrZJFgL6JBOMvEZ3Syk1vEH661TM3PupMrnAcPoCQDmPBL1paFln5FziyRK+88PM0qD
 F79bfjn718UUZjCcYZYRGCD63/colJlNRDcQhqaOX1Km/ZDrk2k4pvmU6bPdPizNGN7n
 4gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797914; x=1782402714;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMuczNx1Y2CV0a6BY4byz1kAAhc+cFwhJZZw4ObJmzM=;
 b=nPkdmeEeiecVYD7vrYOlrNzv6Cobmq0rGmrx1mZ4rkAlFXK2bfCVsAc/vQyEccTcJv
 ci6b4KZTDQ9RMkGBbGyMjoqQ5Ydw+EytFbS2IRY0Vmawxg5PFar3ID+UcG0nxQX0YuzF
 jcefB8laK+xNs/DaY9lFF6uTu1pyVwy36/vcgkjYtr04+dcWOGn2sZutmRHZwtNMpFna
 pJzLqkpiGfusz03IDeOLGvoHOW0Q1mF+t09tWQ1Pb21QAHIJQNpCTu0MZDiXeZtaIdA5
 hxuTrnkrMvO/W0YJND80UXVtAXleYYGf+BR7V18CDU/ADLd0PCH0+ktn2I6aEUESQ8Cn
 P9Gg==
X-Gm-Message-State: AOJu0Ywb/yGMdFnK3WTg71X9S4TFXH6gRp3LNwEK8brqQsqU24LJ6imS
 WzxOoFECHmb4QhSGhJMal8Pz38l5V6US/TvO2veR0oNzNndYeMHFzqlIhGJYRvp07sPZUVbcavH
 HKDUM2tX5X2gHMfrsaZlsr4ZZJeyTbtmiBiLuGRRIOn3H9gDZuISOmYVu
X-Gm-Gg: AfdE7cmcAnQX0CocmrY3euRvSTdYMBY3DSjckBtFUA0yYIIHHCl0jO0kbah8QLolNBo
 VST98Or8fPV8wJ8nE2fACKwR+d4eXxOX9tPJ2KyYBSC2PGJlVocxu08a0Am5+fdcMoruWnnnTRD
 u7H82A0KQ9t+hKCoetu9HC9czMUmm8IfGJU8undLBYNIsPWQX/ml15iDFzfuto0ZSNxYN1mP+CP
 5KHbvi24qzYlOkdKF82DRMLLAa/ya/FQHCx7mEAj4hGBVu1lm81UnvH8GPmrbFlaNRg2X2PtywN
 CFHf8TFpz5vYAPVmW6eDwtx4o25VsnEXBaqLQ6x7wnaGy4MzBgMZUwRwDcQdFYEaryEhsWG4aBC
 LRHOrD0Lb9+JJfgYzDJiAS4lLEfRP7tvc
X-Received: by 2002:a05:6000:4699:b0:461:a15c:cd8a with SMTP id
 ffacd0b85a97d-4650043a94amr49991f8f.12.1781797913555; 
 Thu, 18 Jun 2026 08:51:53 -0700 (PDT)
X-Received: by 2002:a05:6000:4699:b0:461:a15c:cd8a with SMTP id
 ffacd0b85a97d-4650043a94amr49947f8f.12.1781797913075; 
 Thu, 18 Jun 2026 08:51:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b1083e3sm21219819f8f.20.2026.06.18.08.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:51:52 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:51:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618115140-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618104051-mutt-send-email-mst@kernel.org>
 <ajQJa0N54Ges2-f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQJa0N54Ges2-f2@redhat.com>
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

On Thu, Jun 18, 2026 at 04:06:19PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 18, 2026 at 10:42:15AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 18, 2026 at 02:20:58PM +0100, Daniel P. Berrangé wrote:
> > > It is no longer viable to handle the incredible volumes of
> > > AI assisted security disclosures via email, nor are extended
> > > embargos practical or useful.
> > > 
> > > Remove all information about the current security process and
> > > instruct reporters to use 'confidential' issues. In contrast
> > > to the old highly restrictive "need to know" approach, the
> > > new approach makes all security issues visible to all QEMU
> > > maintainers immediately.
> > > 
> > > The focus is on making issues public as soon as possible with
> > > a viable patch. Co-ordinated disclosure will no longer be
> > > attempted and nor will requests to embargoes be accepted.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Thanks for taking on this. One question:
> > 
> > 
> > > ---
> > >  contribute/report-a-bug.md     |   9 +-
> > >  contribute/security-process.md | 309 +++++++++++++++------------------
> > >  2 files changed, 148 insertions(+), 170 deletions(-)
> > > 
> > > diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> > > index fd3bc6b..b506f9f 100644
> > > --- a/contribute/report-a-bug.md
> > > +++ b/contribute/report-a-bug.md
> > > @@ -11,6 +11,11 @@ on GitLab, taking into account the following guidance.
> > >    requested pieces of information that are relevant to the
> > >    discovered bug.
> > >  
> > > +* Bugs which are suspected, or known, to have security implications
> > > +  **must** be marked as "*confidential*" prior to submitting the
> > > +  disclosure. Consult the [security process](../security-process)
> > > +  for further guidance on security issue handling.
> > > +
> > >  * Reproduce the problem with the latest upstream QEMU release.
> > >    Reports against older versions may not be acted upon with
> > >    with the same priority.
> > 
> > 
> > There's a problem here in that confidential marking is later
> > erased. I feel would is benefitial to tag the security bugs
> > in some way that does not go away so easily. Any idea?
> 
> Yes, see this paragraph....
> 
> > > + * If confirmed as a security flaw, a maintainer will add the
> > > +   **"Kind::Security"**, **"Workflow::Confirmed"** and
> > > +   **"CVE::Required"** labels.. The latter indicates the need
> > > +   for a CNA to allocate a CVE.

indeed, thanks

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


