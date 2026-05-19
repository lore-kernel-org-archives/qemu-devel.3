Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F41CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPR8o-0001FI-Fd; Tue, 19 May 2026 16:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPR8l-0001Ev-8D
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPR8j-0001KB-JL
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779222847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qVU4XG41lhumjVaKUo/MlUmAFKnDlBFQ0FSWd25BJY=;
 b=WZ5OxXnkk7Yh+BTjeCRsq+OOjioMELk/TAgbJv0LY5eIEahA4caCIyvbnrPF1LYMYY2fXK
 BtUBddXp+bIV2z6sKVfNjGdE5PAALJc9K0uJopSiSHZVkl7InhnuZLaAKEo5LTaySDgPpm
 H/DAJJ2x0yD2sml2KskLV4QC7ydT18c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-IQn4ApdIOP6YllIWEr7JEw-1; Tue, 19 May 2026 16:34:05 -0400
X-MC-Unique: IQn4ApdIOP6YllIWEr7JEw-1
X-Mimecast-MFC-AGG-ID: IQn4ApdIOP6YllIWEr7JEw_1779222845
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cc01da8fbeso4066616d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779222845; x=1779827645; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8qVU4XG41lhumjVaKUo/MlUmAFKnDlBFQ0FSWd25BJY=;
 b=JROyIwlupJkhpdqOtY3Jyh1xW5qTEYkRgoL6HovNaRWRBjlb0IOkTc62dlATFyanLU
 OBO+fRsUv30B7Sr0rMPLJ+zCWezzMbLAFTbZ6ko1J/FXls3ekLgyI1TRqJLXpZSiwKlb
 0ZeO+mR2c3W3Vm7ICGjh7MiW5niaIgCoFXr6BONm23Y32ixAj9ymwoPqhm2+vAaQiVyq
 tLR0dxiBcGmtHN/WXXhEq/IrdthUVEzTKFeRWW6dsGAzw5oWMMFxwejoABYYi8awyUaP
 nGJwsneg+dbvL/zOJkfzecGpqYMhnYdua2Wm6mxmxuy0z6IIWpIpEzyaGBbArRcCAZ/r
 Uy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779222845; x=1779827645;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qVU4XG41lhumjVaKUo/MlUmAFKnDlBFQ0FSWd25BJY=;
 b=jCBKhn5FK+f7DgbnqEC6Fb6/Z2dVfj9hhr/tUbnuUe7RjuhUTtQ0Pqeuihqozp6tAF
 DmDJ4aC2RJ74xttfgMXW+d1LBeW+jvRFoevwcJ98xHDZtvq6OLho8iqiENJgGV8h5NCY
 VbXyyFtSukJZ1DyHtZxLfXX4R5OUy6cp5kOEgWY2Yp8esEllPFj4KMIKhHecYuxurOs7
 fl9GDIUnU+SIKDQiLEnM58PE9m2E6L7A2Nfa/eozEUBAp6IV0oCqn5Xud9Q37ANo2gzH
 PyzL0aa6LL+KNKzxnXlkc1gCONiDiIdldNZFWDp8b8b17SK/Azu+5gNsJFtyRT4nfC4A
 j4ag==
X-Gm-Message-State: AOJu0YxZQDeYPd1tiJ5C92SFNkQBs4ht57MD0rOs2RAINwTYWPqUhkFW
 NF4Ur1eKUB14L+R/nRx8RAd6aFtJTQfezDeSdtrGF/sUSGBauT5qu8RV3kRo5E2TNg4oM+Sg2gC
 5HyT1S2kDhyDENYNsKGS3Olv1C3bZqXivSf24CqVASyUfoTFt83HzwXwe
X-Gm-Gg: Acq92OHpkZx5Xe1H1cK2lEs1+QwXaxr6aQZ3a1LxGsfNfIvEPpyHIkpy2ns2z8G3zVd
 z71e8yNSzWjICeubyqhT1h7s/V6w8rycyUmc+gZeOgjE2sAbAZ1kBNAGfmpwtShkXY0eh50dsYq
 6e8IGes69jlaQg83WVfrx7CQ6bhGMExetzu+1R896aw8MnsGyjK47I2XuFt/ORC6zBat4K5MpIa
 szHGKz+iFosx3v6HLA+GMomekuuQxExplzv2FUZ5WAPOJorICFXsHbGB1YJGzoHLELXZb32rUe8
 J0NNcOdruB/wS3DSH/ZWgg54/srchhHDtm2joNKtcsux3wizjIBQn/pYBMXD5n8Sqq1KzhI54m6
 x9G9SUdrN094m+l2YEofhGVozjxNJcSB1EqP7VtfP5oD0CyA=
X-Received: by 2002:a05:6214:1bcc:b0:8c2:b7bf:c5bd with SMTP id
 6a1803df08f44-8ca0f642e56mr341161376d6.9.1779222845206; 
 Tue, 19 May 2026 13:34:05 -0700 (PDT)
X-Received: by 2002:a05:6214:1bcc:b0:8c2:b7bf:c5bd with SMTP id
 6a1803df08f44-8ca0f642e56mr341160516d6.9.1779222844407; 
 Tue, 19 May 2026 13:34:04 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619c703sm103029216d6.33.2026.05.19.13.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:34:03 -0700 (PDT)
Date: Tue, 19 May 2026 16:34:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/15] tests/qtest/migration: Always defer
Message-ID: <agzJOlIFUgG28fA-@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <afoaAsY1u8XB6nHb@x1.local> <87wlxhy8ty.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wlxhy8ty.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, May 05, 2026 at 04:06:49PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, May 05, 2026 at 01:08:59PM -0300, Fabiano Rosas wrote:
> >> As discussed before, change the tests to always use -incoming
> >> defer. Also remove one of the uris from MigrateCommon, a single uri is
> >> enough.
> >
> > A quick question before reading into details: do we want to still keep
> > -incoming URI to work for QEMU?  If yes, do we still want still a tiny bit
> > of test coverage for them?
> 
> I would think so. There is some coverage with the cpr tests, they're
> still passing -incoming <uri> -incoming <cpr_channel>. Do you think
> that's enough?

Yeah, I think it'll be fine.

-- 
Peter Xu


