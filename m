Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A0CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGlo-0006Cq-Px; Wed, 10 Jun 2026 07:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGlk-0006Ag-OT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGli-00006Q-TN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg9/RDSBqafxmjIwABL7gi496cGXgRTgO2DAmhmXvJc=;
 b=TVPLaTl4NG9U8vuSxB1nQiOsD0lPnRALWuys7y75NtSjC003Vtj/1Ya7u0hYcabZNtU/hC
 vgoyogLyS/eqn/fKVhk+lh6hwmrlC42YR4NUSW/Ddo+SxmS1+f2pf05hlNqZIyuuPDf4rc
 x2duy80p4SRKuETEIF9igI/Bc5i+/1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-d1lflDCtMpKRJqRG1pAwYA-1; Wed, 10 Jun 2026 07:06:44 -0400
X-MC-Unique: d1lflDCtMpKRJqRG1pAwYA-1
X-Mimecast-MFC-AGG-ID: d1lflDCtMpKRJqRG1pAwYA_1781089603
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490dad70f95so10704775e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781089603; x=1781694403; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sg9/RDSBqafxmjIwABL7gi496cGXgRTgO2DAmhmXvJc=;
 b=ncWUCVdhH6EP/Ve3wiPDFKS7R1Ddvrgdw/GbT3K9V5Q9GLA/Mhvbuestoyk4LZuSMR
 SB97JhfethJjSRgqiMpkbtyfz5rvm+BF0z+tLywhYBSYXaTM+IbXMSPLz+tMXbnQcB6X
 pdM3e1gnMzd6doIY0axDYnprJD2sVZ02o+DqXFMPwarhOKdY8Bn0Rz4RvakfPXiCR78H
 7OzoANuhpwRC1qjeTMBbvLFjdlAByy8UcPYTckVuEFVH/hBD7gWClVRcWj2A6zd+SKPB
 /giWDz/VdBuITibx+ULqtCyz1+AqSp50zrHFljNGcFu+pSguGk1Pd4WdvgUWoTkbejqj
 XGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781089603; x=1781694403;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sg9/RDSBqafxmjIwABL7gi496cGXgRTgO2DAmhmXvJc=;
 b=TiDmw6Wp66tOftTZTRnOH78D5ELo2jeKjl9JIBuGU+r6gsLgT2YCjPJKfHFET6v28t
 qu+0pItujaoLn24KS23faT2RzG06/x9Lh5XUi6eeNcZGD6GXn5QilVorj58+ccwGrxTz
 y+NwspvrbK3jd/m02xgrpmIvJcKuWuE/tffmsHRhnBBTG5f7KT5IaveT3sa5Cc7L7QiU
 3mx801cGNYsZQrLLhoTFAoQS7zlfrG6rdvc86P74WTVtMIwhHfdhxgcSNyk+7+3ysSDe
 RiW4xS088Ru0R4+W6yd6AjIuazL7SF2WDpfcoHh0CjrQtT7+91HIdIDYDH7Fxq3kwx0X
 RoFg==
X-Gm-Message-State: AOJu0Yw3kHmIbHTsLwmernYw8/4H8SMmq8pisGRj+Lzr9K33NcjlkdG2
 PtmfLoaXY8HoTUP07dieunEY25DnCPH7N0LWdlWAjxaAC9ryuvdJGggJYE/FPNaF76QhMUz2Y8w
 OfwqnqTlqOjFShMhHa2foXAqoXqkMjXMVI2UxaBmXJkmB87Zn8z8JmrVF
X-Gm-Gg: Acq92OH6Xpmi/dZ6hqHuQSYYXUFwp+Q9r+pTxtgdpqe5XlfT41bsVxESNVxOP/hO+tt
 eHAx9TXUBJPNE3D3ph53MOvnRiEL+ACjB6GBFgDq5q8dRM2XtyiHxaS1hNk69r7SM9wl+idfVzP
 WfIxo8TWb+ueD6nRWGAgZfBC76sPBslbAGAQ14S3s5GFnGmAIOcFjy4djBaLwCkRz23q7rwkhFM
 U/OyGpIqM7nae81m3bEmeT9gBuVQwh85+pTsBcHdn4H+f4mE3TJSFio67ibG321mjQs7RE54Uui
 lzCRzAEP36tXTLajfH0sK+9Sim1cBy1FVbo82EkTHDMhBdCuQXj6HNEJr+/kZSER3k1iiPlj3Sg
 gfuJLU/KYWv4df4RaoN3Ua0/9MYw4ZFqcLKEvdSwrIurpupQgVGJURA==
X-Received: by 2002:a05:600c:6389:b0:490:33b3:4be0 with SMTP id
 5b1f17b1804b1-490c26233abmr406825445e9.20.1781089602766; 
 Wed, 10 Jun 2026 04:06:42 -0700 (PDT)
X-Received: by 2002:a05:600c:6389:b0:490:33b3:4be0 with SMTP id
 5b1f17b1804b1-490c26233abmr406824885e9.20.1781089602285; 
 Wed, 10 Jun 2026 04:06:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b59f0sm634909185e9.2.2026.06.10.04.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:06:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 07:06:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
Message-ID: <20260610070452-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
 <20260610061728-mutt-send-email-mst@kernel.org>
 <ailEU05AQzlm1fTl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ailEU05AQzlm1fTl@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 10, 2026 at 12:02:43PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 10, 2026 at 06:18:39AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 04, 2026 at 05:50:48PM +0100, Daniel P. Berrangé wrote:
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
> > > ---
> > >  contribute/report-a-bug.md     |   9 +-
> > >  contribute/security-process.md | 280 ++++++++++++++-------------------
> > >  2 files changed, 119 insertions(+), 170 deletions(-)
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
> > 
> > Do we want to do like linux does, and make AI found issues public,
> > on the assumption that bad guys can find them just as easily?
> 
> I'm pretty sympathetic to the idea that AI discovered issues
> are "effectively public", but IMHO that's not quite the same
> as "actually public".
> 
> While people can re-discover things, that doesn't mean we should
> do the job for them by publicising everything immediately.
> 
> To me, the main implications of the "effectively public" view
> point are
> 
>  * Minimizing time-to-fix is the core priority
>  * Process needs to be low cost minimal external dependencies
> 
> Delaying disclosure to suit arbitrary downstream vendor's or user's
> update schedules is not helpful. The only delays to publication should
> be to allow a maintainer to get a patch prepared, nothing beyond that.
> "Low" severity bugs can be public immediately regardless of a patch.
> 
> With regards,
> Daniel


Ok so you are saying the process will be: 
- patch posted on public list -> maintainer makes the bug public?

and if the issue is coming with a patch?


> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


