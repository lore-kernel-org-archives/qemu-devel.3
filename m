Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD522D37E4E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2tp-0004ri-6Q; Wed, 14 Jan 2026 10:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2ta-0004nY-GM
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2tY-0003RW-3i
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768404889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCWA/9J3Z5uJmhBp/KklsSiDjUCf5DddXLHj49vH0M4=;
 b=fnvNGYHkw8JxN9yZwJt7KlgdvJgjHOj+LwNUe3T6HBHm+CNOe5poEPnZkLR7/obP1752Vv
 6Uvk8oqzrnrLvchAYECAC8IaRpS6Tz3V5JWq46SHMaYu25Gyoo4uMuofVO0Ewh58Tsd0cl
 vhBivHVM4W9a72yLc9a3MSSlPIWFV0s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-HINRV3QzPBGM8Kt-i389mg-1; Wed, 14 Jan 2026 10:34:48 -0500
X-MC-Unique: HINRV3QzPBGM8Kt-i389mg-1
X-Mimecast-MFC-AGG-ID: HINRV3QzPBGM8Kt-i389mg_1768404888
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a32bf024cso93728386d6.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768404888; x=1769009688; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bCWA/9J3Z5uJmhBp/KklsSiDjUCf5DddXLHj49vH0M4=;
 b=gLWJ7QSHy9QoEt1PJiSsw7QL7hpR0ag7Jcig/XhXhhN6cs++8MQNsh3oavMVES5PkN
 RsG/BN2EkPPcEFkZoE8NgFXDQuS+7grBNWPbt5wKnvrxYV+4J+pmUP8mrQZGbYo7dHwt
 anAwQZr6cb+iGj1qBu//rf+uAtH8NIK5Ztk3TZ8DsFOuJFph8u2rKIUJ89RhDTVQ581Y
 FpR5NKhgNvwhfK6/s8G4gG4eBSnkp7yik6zAh26haMUrgbSvetP6AycSDeghwyWzuS6P
 U+9tsH2ZeqimuETACk8DVAvQaSeWtvNfEKA8+dtHtHlbezJ1Cx1Ukk7SFX6leAJO915N
 +Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768404888; x=1769009688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bCWA/9J3Z5uJmhBp/KklsSiDjUCf5DddXLHj49vH0M4=;
 b=a/RQVaHOC/vBVvDqCT10fqHaCTbx9fknj+hqyx97eTVODK/NlEa7o4V10y+OnMdGKy
 wPs0PIfhyxSTyTklTVBh6Gz4tceh9LSPFf3tkw4wbKgwgwJ6tPsq8l26eWhABf8T0/1S
 j4JFhf9WSrylFvEtgzYXqJtHPnj1AqiRRJBmYWpVq67Xp0YROy1tLNsqHpIhDoskRRMF
 yvctJyxXj4DD3HrLuy08Kwr2KRGHsYffxcg2tQlWR1OUCPOBmNc07EiT6H/EgNLMkdUm
 oCXnl8tEJ7YwnOYLhGT+dFRCSJ94yn6fkSGiWbDcjjsdQ0ltxT5+cc6ZqhfRp76uveOF
 61ZA==
X-Gm-Message-State: AOJu0YxlLHNu8+tQV6vMBxMkvpkHxlwBK/9Pj8kBZB/etMJ40TkwqSvs
 LX3n6sBg0XPD+I7sDy6fQxkXT3MLz1gipbIDHq8tbWHa/m99migbLvHzZ6bCpr7oAuXRhwp1Gvk
 wSq0yiQX/sbOknee16xsEH8z2MGnrfz/6pV2pd4Wws1/OMZNNStBsa7Nm
X-Gm-Gg: AY/fxX51Ja9Gu91od4CDsy0LBe1Mu87w27aUsWfvucLZG+Tz2MsH5FoHXBLzITCRQz6
 xcn4LBA4H7jhyAcApN41kaR1Lka0+s+ZveyYaJEfkWljayGUJYIgHE2Ty15rydSin/nPZD9tmuB
 jAiK38iSqYU+UGgXLplMUzgIEqYrQuwKQd1FzxxsrClfToEFFd+g+9dpYytfaCMOrqsYaQOpXYq
 EuaSkaVzHs5HXeIzZwGDh3ft3n8bafkj+3NTN2oXQfUdPeYREhfOL8/3ZP4UE7LyQevcXw22VtZ
 iBFAmkLIDKhtmERgTIW+HEqiYTtZZxkZ6hNG/hm/2ZXZVatIF44g1knz2e07BOaU7RYFHqS8UX0
 B13U=
X-Received: by 2002:ad4:420f:0:b0:87c:1f7c:76ea with SMTP id
 6a1803df08f44-892743cf98fmr26966696d6.44.1768404887550; 
 Wed, 14 Jan 2026 07:34:47 -0800 (PST)
X-Received: by 2002:ad4:420f:0:b0:87c:1f7c:76ea with SMTP id
 6a1803df08f44-892743cf98fmr26966296d6.44.1768404886957; 
 Wed, 14 Jan 2026 07:34:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770e20c7sm179266336d6.17.2026.01.14.07.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:34:46 -0800 (PST)
Date: Wed, 14 Jan 2026 10:34:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
Message-ID: <aWe3lXEsr_dsKzVU@x1.local>
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-2-peterx@redhat.com>
 <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
 <aV6T-JDXv3wa7tdc@x1.local>
 <CAE8KmOzCYg_55J9J6Dh6Pr2D5wp_YLOXZqa4cm=Vt35ZDkiUXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzCYg_55J9J6Dh6Pr2D5wp_YLOXZqa4cm=Vt35ZDkiUXQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 08, 2026 at 03:08:04PM +0530, Prasad Pandit wrote:
> On Wed, 7 Jan 2026 at 22:42, Peter Xu <peterx@redhat.com> wrote:
> >> * Should 'hook_data' pointer be g_autofree too? Where is it free'd otherwise?
> >
> > hook_data is freed in end_hook().  This patch doesn't change that fact for
> > postcopy.  It's the smae to non-postcopy tests.
> >
> >> * The changes look okay; But if tests define hook_data = NULL; Where
> >> does it get populated?
> >
> > It's populated in start_hook() conditionally.  When populated, it is always
> > (and a must) to be released in end_hook().
> 
> ===
> $ grep -Eri 'test_postcopy_common|test_postcopy_recovery_common'
> tests/qtest/migration/ -l
> tests/qtest/migration/framework.h
> tests/qtest/migration/framework.c
> tests/qtest/migration/tls-tests.c
> tests/qtest/migration/postcopy-tests.c
> ===
> 
> * Only tls-tests above seem to define and use these hooks properly
> along with the hook_data. Postcopy-tests and all other users of
> start_hook/end_hook don't seem to use [postcopy|hook]_data at all. Do
> we really need this hook_data parameter? Couldn't it be defined as a
> tls-tests specific object. (just wondering)

Sorry I don't follow.  We need the hook_data for cleaning up tls objects
later in end_hook, for either postcopy or other tls tests.

> 
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks,

> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


