Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E874FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENBD-0008DJ-6N; Wed, 07 Oct 2026 04:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIet-0005wP-1J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEIeR-0002Vz-1D
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791344943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NsBAXF8tULn8PDDEhrPvgkw1HUq+tKOSuBljdEBtG38=;
 b=KsASxnGNNnupUqy4CAhYlGu1XY1xhll8MW7e4X+cfnAtaHXMD/PvLeWW2hn8Qxxp2Ldnkq
 JoEe/BxrKnAcOrmK/noeVnfjM8dG1nNKt8DQdSVKWZJTzBfCb+fqeWkvn6I+kUXfRA4WAq
 A4nFeU5zKvFP/ZlKdxSqw/iOlImD/pw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-A74zxZPwOieTvr6ZMDloLw-1; Tue, 06 Oct 2026 14:39:36 -0400
X-MC-Unique: A74zxZPwOieTvr6ZMDloLw-1
X-Mimecast-MFC-AGG-ID: A74zxZPwOieTvr6ZMDloLw_1791311976
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91961374299so85713336d6.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791311976; x=1791916776; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NsBAXF8tULn8PDDEhrPvgkw1HUq+tKOSuBljdEBtG38=;
 b=EZCfO+LLKIdDrmq6tqdLpavFfI1nG2+1YfwTDi0v53NT+edUGMIjnFIE4n3+vvEFGW
 6p8Bsx+AoityJY24iRteDsJVRuABHwtpZjIAr8hE59Ks3glGZmWjXt/rzA6VB1yDGb8M
 I8qn4uCrTinszxrbfTOgvGDo/qh/6WsmyaafGfmf0YupCUO4/rq3gADi+8Te1JAOe9ws
 +SnzayvXwaflmyU7xcCRNukmMbLTxywcQfSidpG+eGMhXn+K4p5IWIe0FqIaE6Z4yffa
 bs2759xQlCesrSZxHweyjpXky7F0oC5QUAmP/LRzyp+5DvvsyofxMsFf5kDWCYDBspHD
 9UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311976; x=1791916776;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NsBAXF8tULn8PDDEhrPvgkw1HUq+tKOSuBljdEBtG38=;
 b=RkqlhQd6DbGHBYASxhwNN37DflPU2caBqD/FMthAcovgkROmdPgJmeaBhNZ5KA4QGh
 pmfQ8Ovq/VnD78UyprTF/IEr3sbeSsd8CN1jz/sLuYPfjoLlIscoKjERoSisfRJs5Yow
 x+x4mRwERu3SKmfvJDK4nYQ26ICaMdVw3i/O6rtIAozwacgiBY+ZtkujQv7mZxhJkdyM
 Z1neI0oeAJ+WlJ22NSfycWMk+rGevpuiJ5iNwr8yjaMZyKA5iEissYtndul8l+CZLwUa
 77mhY7+1H82okyBzY5WB6UT64mqU13M4u+PNhPYUj8sZePmDTOWb5Fq5XG9YRAm+vBvV
 vbSg==
X-Gm-Message-State: AFuF++l5lpX5CX6R4Vfz7DSVNBBK3uk4N0LvMCHepu+RUWzMy11/OfVn
 qUxcvW7rZ64L85cLkIZV/Fo0OhG/6ZROOE+Xs5gKd4nD7EfT1Mr3guVuSiRAuWhXFh2v1Nn7+iP
 puWDIar7yvaF+PYNSdnAQwn8tsS53yzvd1J7m/suPgIgR0dqDLwzpROlQ
X-Gm-Gg: AYBFou004MZQXKV2/NuXxWMyCUMXUnYmF4ES9boXXzGrEZGy/t4Te5MuhUdR8aY/W/a
 9SW4WyETdHfDL04B05Q3EUAqeEbOf+YIMef4K8IvsYR3I2Ztn1T7fp7qL5rIOkp0EuZ/5nWwWHS
 UflFpVM0fJjgyV//G4igsXjYYy7M/MjvEFxeGI4JPqnEKYM9Iha/ShjNcdWimfazCMQG52Cr9CK
 gkMc4OspqH6BZGhgHxIoi49njvNgHk5rtL57fID4J3fazdLuk7lnMAA0kUsIL+V1cZDvT+2fWiP
 IAXBnyNKV3zJlUNITyX28X3rp3NEiHYlg7uvRR+7LF62gw3T6LrK9XtOonJgsvdf7g6mqeY=
X-Received: by 2002:ac8:59d1:0:b0:535:52c:a2e7 with SMTP id
 d75a77b69052e-53566d8ae13mr39237021cf.44.1791311975641; 
 Tue, 06 Oct 2026 11:39:35 -0700 (PDT)
X-Received: by 2002:ac8:59d1:0:b0:535:52c:a2e7 with SMTP id
 d75a77b69052e-53566d8ae13mr39236381cf.44.1791311975031; 
 Tue, 06 Oct 2026 11:39:35 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53572103ae6sm2136091cf.15.2026.10.06.11.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:39:34 -0700 (PDT)
Date: Tue, 6 Oct 2026 14:39:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org,
 dongli.zhang@oracle.com, bchaney@akamai.com, den@openvz.org,
 farosas@suse.de, clg@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
Subject: Re: [PATCH v13 16/22] migration: add incoming migration failure
 notifiers
Message-ID: <asVAZWDo4mAxpke4@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
 <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
 <asUCSERCr0EkHu4j@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <21631cbe-5b7f-42dd-90ae-e2266fba6f4c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21631cbe-5b7f-42dd-90ae-e2266fba6f4c@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 06, 2026 at 06:19:29PM +0300, Andrey Drobyshev wrote:
> On 10/6/26 5:14 PM, Peter Xu wrote:
> > On Tue, Oct 06, 2026 at 04:58:39PM +0300, Andrey Drobyshev wrote:
> >> A device may take over a resource from the source in post_load(), e.g.
> >> vhost-vsock acquires the device ownership on a CPR target.  If the
> >> incoming migration fails afterwards, there's currently no way for the
> >> device to give that resource back before the source is told about the
> >> failure, over the return path or via the MIGRATION event, and resumes,
> >> or before the target exits.
> >>
> >> Add a notifier list for that, called from the failure path of
> >> process_incoming_migration_co() before the failure is published.
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > 
> > Should we better reuse migration_state_notifiers[] and introduce
> > MIG_EVENT_INCOMING_FAILED?
> So far I can't see why this wouldn't work.  Should be functionally
> identical to what I've done in this and subsequent patches.  So if you
> think adding a separate event is cleaner - I can certainly go this way.

Yes I think it's cleaner.

Not only because I want to reduce possible global list of notifies only to
be used in migration (we still have another global notifier for postcopy
that only vhost-user uses..), but also in this case you didn't introduce
per-mode notifiers, stop matching with what the source notifiers can do.

When reused, it should then only register it against CPR_TRANSFER|CPR_EXEC,
IIUC.

Thanks,

-- 
Peter Xu


