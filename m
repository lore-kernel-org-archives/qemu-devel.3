Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5D7C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hrO-0002ks-Hp; Wed, 02 Sep 2026 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hrN-0002kh-0Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hrL-0003FI-BO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788343582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sau8RKh1nY8KC0fsqsdGXpqjtwo6WCxqJPrXLWvrbSE=;
 b=Pm9gJ8PUHJaNnHW/0R71d2fCOIl6wW+yT8yLrrp/iSCZExOPi8YImkngWQobHidZIyQsTp
 LlIhmtiNtqx9LRoW4F0losNdGu/Vx5DnIsKnyD6NKFApOayNWWJlqYN5KWKUkD4NQqhuI1
 olyR+IZW7UgRYvd1ECEUFKaVX+wLYTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-NzEJ6KzBOxWa2eiUy1gI7Q-1; Wed, 02 Sept 2026 06:06:20 -0400
X-MC-Unique: NzEJ6KzBOxWa2eiUy1gI7Q-1
X-Mimecast-MFC-AGG-ID: NzEJ6KzBOxWa2eiUy1gI7Q_1788343580
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso4752755e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788343579; x=1788948379; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sau8RKh1nY8KC0fsqsdGXpqjtwo6WCxqJPrXLWvrbSE=;
 b=fdHs3UNGIEEAlU+HmeMn9LMEnBBZd3dECl3ACu/GQjyMaSYZfeQvWxLR/nxkum4Nb9
 GWjdZ9FQ84UsYnusuqwaxbvwAZ3amWOmZ5+bzon5sJ1GPyD8X1i1GOFaJEG4LlL4CjfM
 EV7+MLovikn9vE9c44lmnNIn2HSf3DespOUAMz1QhPvqmtTwsi31m4SdU5j9OOzt5GcA
 Y/bX8ZV3RY5nvuymWLYDewr3VnwyzKv49LcQPl2ttgF6DDdjXRaX0Hys7WBCMI0Ks6VA
 wkerV4k9PWNfw7f+R+9rHrgmN0wH8k7cCwc8FKKihBsCspXjt2bcujHW/CWUXnzum/0U
 NnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343579; x=1788948379;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sau8RKh1nY8KC0fsqsdGXpqjtwo6WCxqJPrXLWvrbSE=;
 b=LNwXeAWtKz1qQ6rlPx8GZ4AGYNitZSblV2lUpX0TeiRvG0vrslL0SfxV6HKsSNVZ+b
 mdbXjSAIDddqShMYbscgQN1+iA6X0s9CI/0pD3uN84XtBEgUnILFJOMY97Y2CUKWxd57
 AOfqRbU42QnB3fYxzSdn2rnagb2rL9ALXgS4ll3kSFa1KlbYlerWTWnDLXjRCSIw+Iss
 EiwHIaclphDM3sH8Ot1wTv0/nosRCzzWgX0L8KxPf/vJLsoKgH+o/uPoNMZOcPS1tktx
 kZPrr5TjyvzJlTrg9iJRygbAhIDskrYMAolSnu9f6G5lJQ8ViY8laGNeDVGJ0EaJ98+C
 rkCA==
X-Gm-Message-State: AFuF++m2nCK+MLeSM6Jp9rAUAbHy5hjXSZUguFbmgILA7///Sjw2opKa
 tTZiHX3m1TCpWCseGJxHTxoBUUyjCdp5CaaKS1TOzircEUpDWQ2pncmA/2C22RzKlZMF/b9gswa
 0EWfxAEtvruGCtcT4bswozVuUNjKDzBURfzS+wWEdYlgezjkNUqqu2R9X
X-Gm-Gg: AR+sD136e3BbZtOK4MZ8/ASlrb3mPviTL9Q830Z+iME++J9z8LlAyri38eitgXDvEZd
 bRg9uflwCmvI/K8fVv89xdJlNZCgc0yVnj9A1V4VV/QXT8nZhaq0a8Hz53vA6P+TwAO850ag/Bw
 BL01eWyqR+c1XQj+G/4NAN/BTTJVLNvGsWWrBjjIZOdyetKqaTlEjpt6yNiqJOwVF/9EqQ1X297
 8YdXwtV4D8duRbZadpuoiJcMRKFejpHaPoWwdQd4HH7QhxlH0HFhHS6D6HGjf9HSVXn5iJQ2J2u
 nNgIWnZW4Cds1PGT1EpShVr0bHq/+7PLkOaO4NKZpYNm0zNE3l9cdBMblFJ5O+xi1ZQ=
X-Received: by 2002:a05:600c:6992:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49ce58034admr68802495e9.7.1788343579447; 
 Wed, 02 Sep 2026 03:06:19 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49ce58034admr68801295e9.7.1788343578971; 
 Wed, 02 Sep 2026 03:06:18 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce309e418sm79909395e9.13.2026.09.02.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:06:18 -0700 (PDT)
Date: Wed, 2 Sep 2026 06:06:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Message-ID: <20260902060604-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <20260902054543-mutt-send-email-mst@kernel.org>
 <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 02, 2026 at 11:56:46AM +0200, Paolo Bonzini wrote:
> On Wed, Sep 2, 2026 at 11:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
> > > diff --git a/GEMINI.md b/GEMINI.md
> > > new file mode 100644
> > > index 00000000000..43c994c2d36
> > > --- /dev/null
> > > +++ b/GEMINI.md
> > > @@ -0,0 +1 @@
> > > +@AGENTS.md
> >
> > gemini seems to support agents.md - r u at the latest version?
> 
> I tested and it doesn't load it for me.
> 
> Paolo

ok then sorry.


