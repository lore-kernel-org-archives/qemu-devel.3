Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A54310FC454
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAb94-0000Ah-3G; Wed, 08 Apr 2026 18:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAb92-0000AF-TE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:13:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAb8m-0002l4-S8
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775686155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gp+U6k6Qt38GugSjJSVW6koIzuDrvy1XIy1M+JLr0yU=;
 b=artnDaUvxleyY5WtcpAFmCQlEheV98cjqS75EP4UraXlSNKegeXDDqmnKzgyKnwBxCCZ5U
 p78ukCafRodQj7Ew70NDBbKkQxQdzVhUsERmZXxNfDqtKPL/fT6aYNWPU9UIMS2sh4fcCD
 bAARIWA1wkS1NlOiZbORA7rHBMIaVI4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497--4sXviaUNT-TXc3839yB_g-1; Wed, 08 Apr 2026 16:04:52 -0400
X-MC-Unique: -4sXviaUNT-TXc3839yB_g-1
X-Mimecast-MFC-AGG-ID: -4sXviaUNT-TXc3839yB_g_1775678691
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfd0a23243so64441985a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775678691; x=1776283491; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gp+U6k6Qt38GugSjJSVW6koIzuDrvy1XIy1M+JLr0yU=;
 b=fwc8721HEJbqpadl1k57qFWdt2H3DAgcBCL8wxN6UL2BOWFTdrU0v6nm2c2EJbJlmM
 HWndEjMLTcYKGlFcjyAbur/M4sd4E4EPF2Cs8aW64K5vfDfgwXX499ykj9COGLu4RQkZ
 oXNRoNHdgIT8t093MQ3jL0/iDPgVBuiUl5e3zb6YM5Ecry93JoyYBOUu3W05g9oAW1Zt
 AoN7SSVLE2sL9EWIQMo1DzkabDd/+qrN/yV8TusYTE1/fUkytIIoAPXILWyRC1BbCRoh
 Wdy3RHJWKFdaVjhyDNxEqkRBPgwK42JMn0AYhYXtkFmR6IeOiFp6of5JRqcZS6vFiKu+
 aDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775678691; x=1776283491;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gp+U6k6Qt38GugSjJSVW6koIzuDrvy1XIy1M+JLr0yU=;
 b=B+IWNDYlgY3qNm/PbVjNxXGQL64svFWMxfcPu14K9cIFlcQtBmWxgVTpcixqTpoqfJ
 Ywda8ltEKkFVEJq/Ee7rn33cJrHnsvIljv0kTd/ARxNxgUJSx53ZZHUOFG4RUtxDxEV0
 XYOIGy8q5JbMQNqiHIgPKUW4puQk/HaX9YCaha3q70Y2Lbq0Du/QCwsakf9Wn4a7Hpyy
 6eCZzRAZv5vPKXe7nq6n6m9aWi10v1mJJ54am8eKU6KYptD3gnoYBwwKBWWRaFDP/VI4
 YO7IOcCNWYgeYPKvXzMu5obdmornbyKlwXH16ssI2jJil6H4TcgTAkFVugp/ly4BdFTl
 3Ecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB90bRELESkX5eVo+eaFAciQOZqHmA5w3OK5QNLsoh8ZaWWeGM4ZLAu8QewfXXFS0rNCZEnV4xGb3c@nongnu.org
X-Gm-Message-State: AOJu0Yx1j3FycJGGnMkuIqXIL3JnEIWlLQRg1qEig4hsiOV+AHiwB1mi
 a36gPCfYI3athK3/TqC/+MregTHaT053tC9MUuNDUS5BYO8m6JYeF2i70K83HaH0So+3zDgAJuV
 m7FtJuZSpfOB6hNIevamlMsoMvZ8jk3gb2VhU509xrK2AdEy+yUhVxcRT
X-Gm-Gg: AeBDiesQbNMpvxARUXi1XVzgKalawNVPSk+/3KGim1+Z8q/VlJmG0HyTS+TM/kpXvNr
 Mtzwsrx4a0RkdK+UNuKd71zJJqcau9QU559rRLdb/23dU/ZXrvoJP+/yUREUZmQcFxKn9mLRpPD
 TsKnqdaYcIIkn8wanOKZXug5/hsw0U+rpYn0cL45RYD2o7k64JBsAtuYT1oYfCa5UGWoaRaRnvn
 180KZcjgYidQyDJck0eQ3Woh15IuJdFXdxs8VCr7vy8QAoTujrsM8PdwvJjvZpGsO2iOKWlet8X
 zAI8ObhGoPJppFzhW9SFe9t7OynXvdsstEhpIcSWdb8kvOh1XksQygpOz9DA71Omn/Ut8H1vwdk
 Uv/fAhZnGcdAfFd8YXbWK+kl/h7ENIh4eiRMRrtIAfJTAx0k=
X-Received: by 2002:a05:620a:46a3:b0:8dc:1efd:a9fe with SMTP id
 af79cd13be357-8dc3ad2c5b0mr171162185a.22.1775678691374; 
 Wed, 08 Apr 2026 13:04:51 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:8dc:1efd:a9fe with SMTP id
 af79cd13be357-8dc3ad2c5b0mr171154985a.22.1775678690629; 
 Wed, 08 Apr 2026 13:04:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a806ce52sm1887565285a.27.2026.04.08.13.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 13:04:50 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:04:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org,
 Claudio Fontana <cfontana@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <ada038hgmY9hNqPK@x1.local>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qb05gq7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > When query-migrate is called on the *destination* QEMU after a precopy
> > migration completes it returns only {"status": "completed"} — no timing,
> > no RAM statistics.  The source correctly returns total-time, downtime,
> > setup-time, and full ram stats.
> >
> > This series fixes the gap in two commits:
> >
> > * commit 1: Track start/end timestamps and per-page-type counters in
> >   MigrationIncomingState, recorded in the receive path.
> >
> > * commit 2: Make source-only MigrationStats fields optional in the QAPI
> >   schema so the destination can populate info->ram with only the fields
> >   that are meaningful on the receive side.  Fields computed from tracked
> >   counters (transferred, normal, duplicate, mbps, pages-per-second) are
> >   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
> >   absent.
> >
> > The QAPI change (commit 2) is ABI-compatible: optional fields that are
> > not set are simply absent from the output.  Source-side callers are
> > unaffected because populate_ram_info() sets all optional fields via
> > has_* setters, so the source output is identical to before.
> >
> > On dst, {"execute":"query-migrate"}
> > * As-is:
> > {
> >     "return": {
> >         "status": "completed"
> > }
> > * To-be:
> > {
> >     "return": {
> >         "status": "completed",
> >         "total-time": 94,
> >         "ram": {
> >             "total": 554508288,
> >             "pages-per-second": 1440234,
> >             "page-size": 4096,
> >             "remaining": 0,
> >             "mbps": 97.955404255319152,
> >             "transferred": 1150976,
> >             "duplicate": 135101,
> >             "normal-bytes": 1150976,
> >             "normal": 281
> >         }
> >     }
> > }
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
> >
> > Trieu Huynh (2):
> >   migration: track timing and received pages in MigrationIncomingState
> >   migration: expose RAM stats and timing on destination via
> >     query-migrate
> >
> >  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
> >  migration/migration.h | 17 +++++++++++++++++
> >  migration/ram.c       |  3 +++
> >  qapi/migration.json   | 14 +++++++-------
> >  4 files changed, 64 insertions(+), 7 deletions(-)
> 
> Hi, remember to copy the interested people in your series. Using
> get_maintainers is correct, but when there's already a discussion about
> the topic it's good to add some CCs manually.
> 
> +CC Daniel and Claudio

The request is a valid one.  Said that, redo accounting on both sides seem
to be a duplicated work and overkill to me, if src has everything.

Is there a way we can make Libvirt always query the results before src dies
and report it somewhere?  I recall these info were captured somewhere, do
we at least dump them into logs?

Thanks,

-- 
Peter Xu


