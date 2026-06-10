Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C755CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGz3-0001et-0E; Wed, 10 Jun 2026 07:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGz0-0001cR-UY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGyy-0001iq-Ow
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781090427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHYEgjF6Zt+eqWir4uq/rrz90imO+9uQzmik8cUFSIA=;
 b=fZJQNC3ys3Qkf3bBz07zJcd6+LrB+sOBmD6RPSwlRUOkkVHOUKlNVLhfgxQ4pw3IuBrmWq
 SPdKBxvFoP2x5m6jz23o1xQwHhnr7GP93AwDWQrAlUJN/2g3vfNnABCKWZQVLbbvAFy73u
 FZO9QqtOPAwCGqJXb0AOoredmLShDLc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Oh_QM3mEMLqpSckoz_mcVA-1; Wed, 10 Jun 2026 07:20:25 -0400
X-MC-Unique: Oh_QM3mEMLqpSckoz_mcVA-1
X-Mimecast-MFC-AGG-ID: Oh_QM3mEMLqpSckoz_mcVA_1781090425
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b9318944so47380335e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781090424; x=1781695224; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HHYEgjF6Zt+eqWir4uq/rrz90imO+9uQzmik8cUFSIA=;
 b=lOkfB0P527fV+mHKTy7L4CzeLDthJaNdK63xWB29AY3DI+YhuH9kJapbgMjz9/5b0P
 4ULlqRrGvkUGxWw+aqf7YDyGLog7YygirVaB1Lm51S+Tj/TRPiiDg/zcPqxeI1k2ajB8
 ke10Pwz4TKdYYHlFEtBAcfThqBPZlBWzDVxCLSkZZWQE/aBv889GoJjkBEmCQF0Zjyf7
 /ugyDLZURnOlw5NlSJ9YZ6Dt3xijxVckQGkC0IpG3skyEgsrTOiZFwq8QVvZ7HQ9BaLw
 dBvHlLR+a6S/XA4Xh6rWw1kRLwt52cQ/IGAXYRuAW8SHMKAcKsIJnO4yvFQ/Aad3TGCb
 aDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781090424; x=1781695224;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHYEgjF6Zt+eqWir4uq/rrz90imO+9uQzmik8cUFSIA=;
 b=lXk9sAXX/bAOztoX7F49UW2bC3iECUi/2Zl9cY4hIWuoDZhcION+fYvOwuSkZLjpSq
 0V1kWh/AlvKIOIi2ADARjEEEkfqDo2DDCEqrxZGPlTrupbUmgFHJuYYaUAz3b57zhNHB
 9/eZBNxGojwpKd9ITKpigGv65b7w0dt4Dns7/1Gw1yg+XAjLcsImlbHtaXM9JxGzjFj5
 OvHjAPxyc/3y6F7eCyBKEMywgID/cIGfHFcedEb8t6KVEpKrM/nnSn779pwuALWMpMng
 DE9LnmqzkuSv4o7Z2gb2Hkq/Ytoxe98d5jkxgWaKZkY+W3y1eo9OKuA936asxgGUzzVz
 h5DA==
X-Gm-Message-State: AOJu0YwriYe8yoLkddH9EcyIqEKI9v7s0vrRG5MIFl7ih0N1y6trx+tN
 UJfcmT4lp3BxyuRtNOgJPKsRKao80DNW5HnH7L6JBo4b43yxr/dAs42IFHcgwsB0lJ7+TzuGC0n
 z+KZ4XDFKRlk3BDdCmxk0EHvOLBlGR2sOY099ersgZ2uHcgPpz1rKu5nv
X-Gm-Gg: Acq92OGTznpORj7myg9SYw0Ot/2G8vjz+hkzYL6vmhclx419ynxj7DIrg1pZOtCo2iF
 S9r1Lq9ek+2Y4vR9hjn6J2l6LtiWIJPv2mPhLUqtkCDm50STlsZCEsTK8bxtT2DZ4KgY+FsuxRB
 c74XQ2C6VO/iZvx9jtj5q48g9e+gX5UA3Qej1BoAXCxpVpmc5pWkXAqt6t50PlQ6WV9hkmNygTK
 38Ipu0WIM7m67KSfA0Oon5cGIUSsTWznjuycC2ksvRDpU+JKUeYLBYlG1JrZvAJb+sxAcUYU1km
 4YUkT7BmqYenEstujyunOvhpvAthvabvXZhK/0i2pKFc27rPYBBV4lV2zDD2AyDmG7pbjJTfRgs
 0myD5xvEcO8nF0LzPFfkqo3ojY4l3srLzT3eVFdweXfgJ54XI3gUwGw==
X-Received: by 2002:a05:600c:5394:b0:490:c2a2:e91f with SMTP id
 5b1f17b1804b1-490d724bc47mr98007625e9.35.1781090424389; 
 Wed, 10 Jun 2026 04:20:24 -0700 (PDT)
X-Received: by 2002:a05:600c:5394:b0:490:c2a2:e91f with SMTP id
 5b1f17b1804b1-490d724bc47mr98007085e9.35.1781090423944; 
 Wed, 10 Jun 2026 04:20:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dc4715e4sm40501525e9.0.2026.06.10.04.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:20:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 07:20:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
Message-ID: <20260610071756-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
 <20260610061728-mutt-send-email-mst@kernel.org>
 <ailEU05AQzlm1fTl@redhat.com>
 <20260610070452-mutt-send-email-mst@kernel.org>
 <ailGDPPj-YfGepTk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ailGDPPj-YfGepTk@redhat.com>
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

On Wed, Jun 10, 2026 at 12:10:04PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 10, 2026 at 07:06:38AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 12:02:43PM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Jun 10, 2026 at 06:18:39AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 04, 2026 at 05:50:48PM +0100, Daniel P. Berrangé wrote:
> > > > > It is no longer viable to handle the incredible volumes of
> > > > > AI assisted security disclosures via email, nor are extended
> > > > > embargos practical or useful.
> > > > > 
> > > > > Remove all information about the current security process and
> > > > > instruct reporters to use 'confidential' issues. In contrast
> > > > > to the old highly restrictive "need to know" approach, the
> > > > > new approach makes all security issues visible to all QEMU
> > > > > maintainers immediately.
> > > > > 
> > > > > The focus is on making issues public as soon as possible with
> > > > > a viable patch. Co-ordinated disclosure will no longer be
> > > > > attempted and nor will requests to embargoes be accepted.
> > > > > 
> > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > ---
> > > > >  contribute/report-a-bug.md     |   9 +-
> > > > >  contribute/security-process.md | 280 ++++++++++++++-------------------
> > > > >  2 files changed, 119 insertions(+), 170 deletions(-)
> > > > > 
> > > > > diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> > > > > index fd3bc6b..b506f9f 100644
> > > > > --- a/contribute/report-a-bug.md
> > > > > +++ b/contribute/report-a-bug.md
> > > > > @@ -11,6 +11,11 @@ on GitLab, taking into account the following guidance.
> > > > >    requested pieces of information that are relevant to the
> > > > >    discovered bug.
> > > > >  
> > > > > +* Bugs which are suspected, or known, to have security implications
> > > > > +  **must** be marked as "*confidential*" prior to submitting the
> > > > > +  disclosure. Consult the [security process](../security-process)
> > > > > +  for further guidance on security issue handling.
> > > > > +
> > > > 
> > > > Do we want to do like linux does, and make AI found issues public,
> > > > on the assumption that bad guys can find them just as easily?
> > > 
> > > I'm pretty sympathetic to the idea that AI discovered issues
> > > are "effectively public", but IMHO that's not quite the same
> > > as "actually public".
> > > 
> > > While people can re-discover things, that doesn't mean we should
> > > do the job for them by publicising everything immediately.
> > > 
> > > To me, the main implications of the "effectively public" view
> > > point are
> > > 
> > >  * Minimizing time-to-fix is the core priority
> > >  * Process needs to be low cost minimal external dependencies
> > > 
> > > Delaying disclosure to suit arbitrary downstream vendor's or user's
> > > update schedules is not helpful. The only delays to publication should
> > > be to allow a maintainer to get a patch prepared, nothing beyond that.
> > > "Low" severity bugs can be public immediately regardless of a patch.
> > > 
> > > With regards,
> > > Daniel
> > 
> > 
> > Ok so you are saying the process will be: 
> > - patch posted on public list -> maintainer makes the bug public?
> 
> Yes, I even wrote that in this patch :-)
> 
>  + * At the time the proposed patches are sent to qemu-devel, the
>  +   maintainers should remove the "*confidential*" marker from the
>  +   GitLab issue.
> 

Right, you did.

> > and if the issue is coming with a patch?
> 
> If the reporter provides a patch, the maintainer merely needs to
> review it. If happy, either the reporter or maintainer can send
> it to qemu-devel immediately.
> 
> With regards,
> Daniel

Presumably with a Fixes tag.


