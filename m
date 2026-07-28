Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C383C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojYj-0006W6-5g; Tue, 28 Jul 2026 11:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wojYe-0006Uc-0C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wojYb-000770-SG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785251845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g+tDN3w34gUKvNXaae/hUChCIlCuGo8BxHp7+kLgqqA=;
 b=Kfc7uiRIl/cHcDjUlTqKLmtmB/WsDomZC9dtzWZoeX4C58vc9z8Kc8qq0ZHwf/aPM1Z/2c
 UkyjwUN7LAUvQNU9wFRSzNSu1+gA4Bk3Rck5Es+SnqqQtwV2Eq4+UbEAp6B/UuhZqAZLAo
 7sVPb/3fp3gNn40TsCRkEU9VUmrUNzY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-67PF_XNaNm6Fs5gFxWiwdg-1; Tue, 28 Jul 2026 11:17:22 -0400
X-MC-Unique: 67PF_XNaNm6Fs5gFxWiwdg-1
X-Mimecast-MFC-AGG-ID: 67PF_XNaNm6Fs5gFxWiwdg_1785251842
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-697d51ced1cso4217509a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785251842; x=1785856642; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g+tDN3w34gUKvNXaae/hUChCIlCuGo8BxHp7+kLgqqA=;
 b=IQVXC0uySTk+C3CnKmWn82bH5vLsP+T1EV228uImFWP0FgKt/TYn7/1IV4FLBSLHhk
 Pc0POnfUB9mM4naR5e9py1nM4KQz13nwzIcxmcFQUQHeww/HPYuVCRoH9yyeMGUtYk2A
 jpqEDl6y4lbtvLxItMo7vfhRIbMGNH358IKA0d1bc7aEAOdYRoE7SmqOgtmlhcGtn+XR
 qcXDIRh2aPsteu7CRuM/42BNSpkN2KMMNCW++eRPFWjcLEi9tsqUgWJeznOtm+X0VzjC
 zHM0sYXwaBky3e2stXHN2lOGpCUkrKnQD+gz77NcxTKBRzh/yXWHMU2oPGbNTz56297z
 1Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251842; x=1785856642;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g+tDN3w34gUKvNXaae/hUChCIlCuGo8BxHp7+kLgqqA=;
 b=BvC63LJAryHCwd4I/ckFePyy1DkBkJLJPoyxMZVeDORYlwXHcm+fzuJdM0wAMd6i9+
 jDr/lsOMm4cVHylRFbjeYXzYu0urWs30+wdYK2y+DEV0idFCP9wrFYFgCehC9xU36/f4
 dsHBayFQONxYKt36wEcFIEXHc2t+Y53d/0Rv/BOQNDOHZVek3QZ+AEbJdoc+Yv/X8HWT
 1VOlRTkITi28ftV/oowd4ESeULwo9w3yMMkXX+ZcpnmPR3tfw372JHZxqFBJovgW9ohN
 lWYWKZa1UPD0+98u7+ytkAXsmaH1U5T9w3JMTOCn6lYrStUfZq0xBW9JZ5eNsH1VsY74
 jcuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwddbfyZ2mGHEoNkJkHKEuWQXBZYxahMo7gwU+2JE4zqAsvtLBmbhjafSe2j+0TdlTHpYIvY5w9KhQ@nongnu.org
X-Gm-Message-State: AOJu0Yybetu6WFbRYS3QyvW7xKAjK/3Vj86XEOsomzPsREzVhvWwviAY
 HUuD5y4N4iFzzjJRSyDNiFU63hbmIGjKLw3/Q8nW7xYDFgfnQoaQ07dqKTtpxyPpp1OAHyvBfqn
 TAu5hd60CaUlrVnxM47QgLU3Gng8mSm++S5ISuR7ljd++BXFTiktHmaXO
X-Gm-Gg: AR+sD139JysZ8zMCjem8KXw2Nojk6kZ50Og/hm6Q+z5QxeYRYvpwbCNM5YuDYo1+GlM
 lM2WiP3QUGa3hudQduRFwPR2TCiFppbGZWyhRhdGfC0w1ddl+ivojqHin8u4yiSI+t+EuFzxNap
 +2ML6dntOV08qE5YUKaKRrkqXe0+cvk+fN7Cf1vP2M38dpe4vGr8GJa2+c/+FNcH6YHRB5NRESD
 51r/431lyf3W1hmtzPDXopeKiRJ0Cuc0NxTMYqlTZ0OwkF4IDxXB3GCTQdiPLjevYw+K40t6E9q
 iGXCmY+FfFMeOYTux7ijJbO3Rv/MnZn8rxZFmxvfSoX/GKTvidsISKdhy5MiEQ50KFeY
X-Received: by 2002:a05:6402:4551:b0:698:5610:76e5 with SMTP id
 4fb4d7f45d1cf-6a0349eaa8bmr1199543a12.6.1785251841612; 
 Tue, 28 Jul 2026 08:17:21 -0700 (PDT)
X-Received: by 2002:a05:6402:4551:b0:698:5610:76e5 with SMTP id
 4fb4d7f45d1cf-6a0349eaa8bmr1199503a12.6.1785251841074; 
 Tue, 28 Jul 2026 08:17:21 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb59468dbsm4332873a12.28.2026.07.28.08.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:17:20 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:17:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Message-ID: <amjH8uXODb-r-_FF@x1.local>
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
 <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
 <13333e56-3725-4550-849c-9035f6925213@oss.qualcomm.com>
 <CAFEAcA9X7SNUvQpwXA2_xReUERB-eBETty3g32-PD=MVk536sg@mail.gmail.com>
 <2322668a-20a3-4a6b-8d7f-c04ddfef84f1@redhat.com>
 <ami94CmeBNRKy_es@x1.local>
 <CAFEAcA-y+vNK2u-rSq+SVjNZrhO2=BsUysEw2PtCdCZ=qYx2bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-y+vNK2u-rSq+SVjNZrhO2=BsUysEw2PtCdCZ=qYx2bw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 28, 2026 at 03:38:53PM +0100, Peter Maydell wrote:
> On Tue, 28 Jul 2026 at 15:34, Peter Xu <peterx@redhat.com> wrote:
> > I think the bit ops should be more efficient. I plan to queue v5 with a
> > fixup, v5 here:
> >
> > https://lore.kernel.org/qemu-devel/20260728031731.286666-1-gshan@redhat.com/
> >
> > Fixup:
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index fbe7df2391..2f37cbeb07 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3162,13 +3162,18 @@ void qemu_ram_move(void *dst, const void *src, size_t n)
> >  {
> >      uintptr_t test, len;
> >
> > -    if (src == dst || n == 0) {
> > +    if (n == 0) {
> >          return;
> >      }
> 
> As we're dropping the src==dst check here, we also need to drop
> the "and the memory areas do not overlap" clause from the
> documentation comment.
> 
> Otherwise I'm happy with the v5 with that fixup applied,
> and you can apply my Reviewed-by: tag.

Will do, thanks.

-- 
Peter Xu


