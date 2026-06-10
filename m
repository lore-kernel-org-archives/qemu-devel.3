Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFE2CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXNpg-0004GL-IC; Wed, 10 Jun 2026 14:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXNpe-0004Fu-Ic
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXNpb-0003HG-QZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 14:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781116754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJwNW4jNLb07h1epy/AdnMNeLVnkIKT5Qgw/rd9Nvn0=;
 b=agJDveOCp96FM0vyotrVdKw5PN/ej+VURCZztuYgCGlsS3uFnm10JsAswhryKbNUeG8NFm
 mva25w6LC6gC/USIcJz6R0HnsjrTd3NXwtS4Elqfl9ypRsmwwiFWipAllfe4moHR1TBBRk
 GFmZ/rRHGJsci91gvyOAZohFsB7TO5A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-jmMDAdqwPTe95NU9HGY8VQ-1; Wed, 10 Jun 2026 14:39:13 -0400
X-MC-Unique: jmMDAdqwPTe95NU9HGY8VQ-1
X-Mimecast-MFC-AGG-ID: jmMDAdqwPTe95NU9HGY8VQ_1781116753
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9156cb14b1cso586983385a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781116753; x=1781721553; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lJwNW4jNLb07h1epy/AdnMNeLVnkIKT5Qgw/rd9Nvn0=;
 b=GYQYFHpz+EOZkzSJt3BoxAdqI0FqAqjf9u1PI7BKpLuP3TBU2MM6kkCjFbUnWm9v/x
 FFRMuR4S5E8HwP7nq4jvZkvFFdzcFezH3S/+AXsX6u95dFXrrLLl5raMBURcnhKJdY8q
 /tWZTF41JsQNPOsGyjt5oSf7Jc2OHdtZI8rRTV463qJCixsJWh9To4ShgdOdUmtX5ek2
 NtwaQf5QlBk6+9gsxbWYBIcsh5T24dMikGuDeusvRL0aFRDgG9rJYCqhW4BDAX6j0/mP
 s/Lq51k/4aYSSMC8WT5N+gX55teMPFycmCYSbSkBk0kxPs3wNz9xuliMQ6tIQn8ee3SE
 heAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781116753; x=1781721553;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJwNW4jNLb07h1epy/AdnMNeLVnkIKT5Qgw/rd9Nvn0=;
 b=rw0xLRihLFVSrxNJJiLbIz3e3a+0kedlQrvsccaEhcbfdGw19QW5LweJLeIZAvQwwG
 C7sprp8nTW3zhkkL7Doq+Vu1qFCHSCqhbMPysXMHroN6oDEJYuHEf5uiCFHAlOeuls4M
 SY5a1UOqVNqomDMB7pm3ECr4uWTjEnrv4TT95tK8h9SQYVQZvdrpomvbEPfiAOQUhtUb
 sWRPbJ0tVWc1cl+XAbJCZTpbougHANNm5rmduS2HMzIPc7TXnh9f/yYEjnV/H1PQomjx
 13RlCstAV/+cQaeHp6TRWw/L1rCocHW0KOwaFSk75LkCrb7HCyKJn/XJNh5cw7h46oVh
 /37Q==
X-Gm-Message-State: AOJu0Yy+Hjw1M3PR/jV1JbTJjNa7v0gjHwio3xQQLvbG+kt6xnqwbyEW
 Rq7jYXOZ7gYaFi2/Hd8eyDu7WXwDWOTRskXWUVZ4eVjMsoiI1LuM2mvOxpMhNO9Y7XSEMThDDoM
 3odxxF5hKbkD+ADZacdb8QWTvtRcwd9aEj5oFnr23h0AMK/eQC6bC9m2T
X-Gm-Gg: Acq92OHh8aWygi6cvQHMlXYyLkKvRWkXnvgWgfIexaMExcQbfEX6bzLEpFetCq+Fj96
 NW43lLENXl0LZQ+eW5RCQAp+/7lE8j45dAagLJvSE7uAfE06IXwXut7ew8na0AHwnSo0s05IVFi
 jsxu1kofnNNFPW50BUAxqu9UTkE4u4EAL511/FriEXBLy+lKgkowK9TWwONb41pLEO+Vp+QEtfV
 ePhFlfCn9ppL8nToxVG7uIRImF2oatzE3hyoSiXIbIrf+5y+NZuPo8ba3NtxF9WfoV6NSMfqy/x
 tYZs3h6ZcmZQMEd5jrHKAV8GSi4b60FFfP5atF7tfgHzDzoyDEkMo2FYbCNXZW28cXKLFnc0F6E
 jSpEMfVojMVHoBbqUsswGypcubA==
X-Received: by 2002:a05:620a:2808:b0:912:1:b415 with SMTP id
 af79cd13be357-915a9cdf822mr4378469785a.26.1781116752846; 
 Wed, 10 Jun 2026 11:39:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2808:b0:912:1:b415 with SMTP id
 af79cd13be357-915a9cdf822mr4378461385a.26.1781116752271; 
 Wed, 10 Jun 2026 11:39:12 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm2491634285a.22.2026.06.10.11.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 11:39:11 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:39:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Message-ID: <aimvTYDsv_-Xsboy@x1.local>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
 <aimNv51iMZ_yEgDG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aimNv51iMZ_yEgDG@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 10, 2026 at 05:15:59PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jun 09, 2026 at 01:25:09PM -0400, Peter Xu wrote:
> > Create object-property-ptr.[ch] files to include all the helpers for
> > object_property_add*_ptr().
> > 
> > These set of helpers are handy because they look extremely familiar with
> > qdev-properties, allowing the caller to provide a pointer and it will
> > manage all the setters and getters.
> > 
> > The follow up patches may introduce more of such helpers.  Since object.c
> > has been already too big, split that part out.
> 
> The "ptr" helpers are all instance level properties which is a concept
> we discourage from new usage, in favour of class level properties.
> 
> I don't think we should be adding more "ptr" helpers, but rather
> planning to eliminiate the (surprisingly little) usage of the
> existing ones.

The other way to do similar thing is qdev's offset way, but IMHO that's
more awkward to remember an offset of a pointer then do math everytime.
Essentially, from technical pov we need at least one uintptr_t to store
either (1) offset, or (2) field pointer when there's a field that is bound
to a prop.  IMHO (2) can be better otherwise we'll need to do all the maths
to calculate offsets then when access we add the offset back and do a force
cast.  It seems not necessary.

OTOH, I still see value on non-class instance properties (that sometimes we
don't even want to have some props avail for the class, but conditional to
some instances when created dynamically).  If that is needed, IMHO it's
fine we still provide per-instance properties.

Is there any pointer I can read about the discussion previously on this?

Thanks,

-- 
Peter Xu


