Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B05CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHiQ-0004Wj-Nw; Wed, 27 May 2026 13:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHiO-0004WD-W6
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHiN-0005hu-9Y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779901602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0izex6XyDDRtNvwr8IVnrtStkQSwfh5f78kI0LXSW8=;
 b=aBhmTdelAV+BYx15cFzHEBMPOj5PvaRoxxmLa8CniJMpAiZUgqGO83Hg+sbA/Lj+DgxL7q
 cP1tcZO+XICVnBoiAf6cDZLUlpppnLedzUI/Xw6G6F02KJqjXzU8LALnii8y9BRk2XDl/g
 8qQt39IdePXmAp1SvBkgW/lQUwsqttA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-gvcqCsJXP4ejrHewePOt3g-1; Wed, 27 May 2026 13:06:40 -0400
X-MC-Unique: gvcqCsJXP4ejrHewePOt3g-1
X-Mimecast-MFC-AGG-ID: gvcqCsJXP4ejrHewePOt3g_1779901599
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7730e9e3so7286350f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779901599; x=1780506399; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m0izex6XyDDRtNvwr8IVnrtStkQSwfh5f78kI0LXSW8=;
 b=COU7gXQTHbHdS81gmKHBRGhjp2RNGxF9DniHOWeNoqipA3ux8h5WvYzDfDUQRcyOq9
 6GUAyJIABWvr+qASxyMv2gcVOloJWJi2PpqaILyA/UkgJU9jw4rKBrwtYMKPUP8XVpNj
 NkLEpFaT+zXN5jbQ0emA1OXlXAZzLTOz/LPXl4CbZBFGIytZbx/G+ZeFAr8XIrMvyowQ
 vhvFW8K4ZfErAPiVWYn5zxE3lI2ZrdRdeGeW3/ApMAfgnO2MrTVrDNbyI+s4tZ3gRU4/
 Nca82Jsl7x9bfSSURNYk5oMu7c10YnmE2tBiOzk+NXGbdVI9ceRLYU9QUQ76AvaKe5Mx
 QplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779901599; x=1780506399;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0izex6XyDDRtNvwr8IVnrtStkQSwfh5f78kI0LXSW8=;
 b=o21XFPjZN0BurT3OsRT4KSmLM0fPskXrIBV0CsPr2TAAqKwvyUpxoPWbHQiERGlyx2
 bHwl2dB64WPl/H5Xgex8Gc8NNc5rtXvX2Fv/gZdDEXZiBbWm4vccsqv2xFbO669X76FL
 eW8iCdHSjA+YlzoX+TqyYm0ZHSmnpg8JGTzF/cEedwkxIK2AxKLAPjXBfSRJY4Zo+F2Z
 2O82ZqycWA4ZfSzda/J35BJlJzMqZADhJ9nWVchyjurTLn1aVgIfViSzvtKU0WJ1RYMK
 kN53Qp5IJGCIMyVAP9mIqzEwCgqVFWM9sudTQSgoqr1/cngjO8zF7PchBlWTepk0RN5H
 rZrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uVFCNkzhgWKkk1VM4w6s5X3KNmFFlgLPkvs6AU7ZWOxxrvmGdQQR2HStPd+dX2ga3FVeJNWZeYmA+@nongnu.org
X-Gm-Message-State: AOJu0YzOq9TU3XKr3TDImM+nNWSJ7okHXpX2HMEVbdDl9VcIswPzB50q
 vzxpfHRPnDsn7YIsFfS+dIJyYkyugztYxzNolEmKcGniktXrSXyCBLu09eZ2PNrzR7pKv6NUTtA
 dsy8BeO84o0nonseBffin3umjhKVSQvaAnXL5SKbnFUB5vTl8RNVP8AK4
X-Gm-Gg: Acq92OGJhK21pHB2vdwRLz/RAXsfu0VDjpjN7RbnxZvJoFZomeXk+3K1tlxUeMUh+dK
 zbObqJIw68spqj8GIJqU3SkB/91vkqqTzXQIdS0GORqoLtuWKYjYpu50r44fONo1DkaMIq/vcDP
 Tq6TzHBlTVP1wsIDdbOjhgIliat5d+KqRxYCrgwVyy5yKQk3XJ09xnzkOzmMd7iBca1S8R28jcL
 Dqpho7MzdVOlm+34DspptatTkQdlRuZ5ER5TzH145vd51LlIaJHC2F8udjTUYaGnwnfPASEuplD
 8V6CjgbrCO9tHkvSoSBi4/AgnF8IeSDXJ3rBxoP0fzdxnZZ649Zw8U5fpwpidrS1Gj1nFhgjf3Z
 bUVsGN2FHaqXn
X-Received: by 2002:a5d:674a:0:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-45ee1a4c6c3mr537648f8f.15.1779901599353; 
 Wed, 27 May 2026 10:06:39 -0700 (PDT)
X-Received: by 2002:a5d:674a:0:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-45ee1a4c6c3mr537600f8f.15.1779901598723; 
 Wed, 27 May 2026 10:06:38 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a296bsm6898752f8f.21.2026.05.27.10.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 10:06:37 -0700 (PDT)
Date: Wed, 27 May 2026 13:06:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527130518-mutt-send-email-mst@kernel.org>
References: <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <ahcE-pDc_7tTrsz3@redhat.com>
 <20260527123942-mutt-send-email-mst@kernel.org>
 <ahcgxpvXFoPE0C-X@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcgxpvXFoPE0C-X@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 06:50:14PM +0200, Kevin Wolf wrote:
> Am 27.05.2026 um 18:41 hat Michael S. Tsirkin geschrieben:
> > On Wed, May 27, 2026 at 04:51:38PM +0200, Kevin Wolf wrote:
> > > Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> > > > On Wed, May 27, 2026 at 4:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > Commit messages for AI-assisted changes
> > > > > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > >
> > > > > When AI/LLM tools produce or substantively shape your patch, add an
> > > > > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > > > > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > > > > explanation in parentheses::
> > > > >
> > > > >      AI-used-for: tests, docs
> > > > >      AI-used-for: code
> > > > >      AI-used-for: code (refactoring)
> > > > >      AI-used-for: code (prototype)
> > > > >      AI-used-for: research
> > > > >
> > > > > The trailer is intended as a clarification of your DCO obligations as
> > > > > well as to guide reviewers.  It is not intended for minimal presence
> > > > > such as autocomplete or asking for a pre-review of the patch, and it
> > > > > does not remove your responsibility to understand the changes that you
> > > > > are submitting.
> > > > 
> > > > Why invent something new here when Assisted-by: is used elsewhere
> > > > and is likely more familiar to other users.
> > > 
> > > Because Assisted-by: gives different information, which at least to me
> > > isn't really interesting at all. It's much more interesting to me if the
> > > code I'm looking at is generated, or if you only generated the tests.
> > 
> > I personally am interested to know which models work better than others.
> > Contributions are about reputation not just code.  I'll learn which
> > models produce better output, just like I learn to trust specific
> > contributors better.
> 
> You don't see how well the model worked. What you see is filtered by the
> submitter, and the policy we're discussing is specifically made to make
> sure that bad results never reach the list.
> 
> Even for things that do reach the list, Assisted-by: doesn't tell you
> how much of the submission is AI-generated and it also doesn't tell you
> if it's "I used model X and a simple prompt gave me the perfect result
> in the first attempt" or "I used model X and it took me two days of back
> and forth and eventually I just rewrote most of it, but there are a few
> AI-generated lines left".

I am capable of observing trends over multiple contributions from
multiple people.

> So what you should trust is the contributor, not an Assisted-by: tag.
> 
> Kevin

Both.

-- 
MST


