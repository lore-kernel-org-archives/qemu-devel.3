Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A722CC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Gqd-0003gg-4L; Thu, 17 Sep 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7GqZ-0003gY-RD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7GqY-0001KB-7x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789669712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXFsLeF4d5X9docjJeODQPv0D2jNtLXJQVyG4Ae3P9o=;
 b=g6DqXSDFuVdQ5p42vhFGViMg7VRlmo33RuAKn0TUDSd5fm8LS7A9K6PTEzZi/vAweGY8S0
 W80c/N3MSB/Kf7pdb2abu/X07VHlrAWqqUS/zkIIwe2e4zKE4jIfikd5ulkUQMJfXQyHEg
 vJBPcBxU19AoKXkjnQRqGAFEiahG6Ao=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-pXj-aZiwNRuNGBtgdx47Lg-1; Thu, 17 Sep 2026 14:28:31 -0400
X-MC-Unique: pXj-aZiwNRuNGBtgdx47Lg-1
X-Mimecast-MFC-AGG-ID: pXj-aZiwNRuNGBtgdx47Lg_1789669711
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fc0097865so32157781cf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789669711; x=1790274511; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vXFsLeF4d5X9docjJeODQPv0D2jNtLXJQVyG4Ae3P9o=;
 b=lBATUR1wRHX+KsSlaeoypZdHKDOqrJ6MFvwMKRjjf+lMllpDUHWNf+NZDofoLbEEiz
 tRW42H9hj9jwR0EvOE6mJvsYkBfoYenLs8XtU+5tQlSR0ACzS38vkuZjLxtXbGUmSS7n
 m+Xn/8FZtdnxcRLUWPChHG+oZhzu+iAhj/Qxw4+v2CKeNzT6n7lrBs4duANP/iYa7hFk
 rWMleCoxCftJ83v7MfaOXR6jBfdMBJeil7Cf6lJA4iotNOS95mfwwQhXy+anK30BlSHJ
 ogGVnVZl8RLcvne4Ulqh5oaa8nPH9Qio6l6TqM9bI39BpyDI3Prr/sRy4EFxECRj6BZV
 9UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789669711; x=1790274511;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vXFsLeF4d5X9docjJeODQPv0D2jNtLXJQVyG4Ae3P9o=;
 b=1bP80fRNViuc7eJNqGgYm1aZWEaYL5uP6jQHfZ+ZrbgbiMgfjMphnobrKHkMeu+9ow
 fNgVv/MwfW2WoRfrPJUOceveDODOhhCs0HtQIBjiyn6z2F148uZBKTdT58Ziljwo37tq
 8szKMgLXs7XTsJOgJnW438uonIPLMJjzBOZfqo7vtQ5jfxrN3XZY0etviHb9IwR88ikK
 ovheD15Fm6qH1vuWe6sd9RPSBRdZyn0gM2QxTQ1USDk/1rGkDT5MuYsRAFlAjEwjnlSB
 /JQIGo8lFGiImE/bjS1krC+xtEDhydK1GnR4s4vQyoiWfdiobHjAkUTR1OokMLbpAnvF
 MVDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRonuTm7JLqv0bkd2JLJm2rtV58ZiW2KZo9TSPrmyQQb5ym13zE67Xw1Dpm3N4nCHxIrPABSlVXI5j@nongnu.org
X-Gm-Message-State: AFuF++nleIEX1hwIKuHAWAEwWVsFlKHAMNODYCI58aXsQOzXffe5xBk6
 Up2M4k7BoPI8TutVcvvqjK3YMmBd+YADfPJ67aDkPlvoEnXEEkBqX8TUr6fAovaNfWBHkNo6BfC
 GYv0CbniDIMGI36bWNZvXn1j+ByW78haOEEeoE7aT79TFnYf0OIf3+XZ6
X-Gm-Gg: AYBFou2H2aAfoejLwSnNn/FP8embKeDu/a9smWu6yimvCq/nEP2C4t5BFXeC1t4Rexz
 yNjtBlrELX18nH70xKSEDd/3/8KZLajiSQVoQ2Y8Im6gpKIvbw9hzn7/cxrW+9OsyKBbnD0OdHK
 rndne8BICiA5fWY91BhIqOjUiGcBkhmn8+QztMC79hslzGW3Vfy5vuBicBblz+pMQQ6Jb31MjGy
 vlQZu7FZG+H3ylANcc9ncfnBgLacTvfVhP3Clt5Dxy1/5jwbzf4/wJoDD/DxbdUtW9s1xb5GOXQ
 Vp+HrF64uITiCm1fYo5uKY/uZSVdUbG8GY61Bh1bAF1WhUTfk84breGB6HMco7kgEQ9J
X-Received: by 2002:a05:622a:10f:b0:52d:7b2a:93b with SMTP id
 d75a77b69052e-5329e25a802mr1690691cf.9.1789669710723; 
 Thu, 17 Sep 2026 11:28:30 -0700 (PDT)
X-Received: by 2002:a05:622a:10f:b0:52d:7b2a:93b with SMTP id
 d75a77b69052e-5329e25a802mr1690151cf.9.1789669710084; 
 Thu, 17 Sep 2026 11:28:30 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532620acc1bsm54451581cf.25.2026.09.17.11.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:28:29 -0700 (PDT)
Date: Thu, 17 Sep 2026 14:28:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 13/20] migration: Use keyval input visitor in HMP set
 command
Message-ID: <aqwxSbBEIYUC5Xp_@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-14-farosas@suse.de>
 <87h5jo3zl7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5jo3zl7.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 17, 2026 at 01:08:04PM +0200, Markus Armbruster wrote:
> > +    } else if (g_str_equal(param, "cpr-exec-command")) {
> >          g_autofree char **strv = NULL;
> 
> Not this patch's doing: initialization looks superfluous.

I do see most of such cases in QEMU we initialize it to NULL.  I think it's
a good pattern for g_autofree lines so we will never try to free garbage.

Thanks,

-- 
Peter Xu


