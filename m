Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE59CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQI6-0004QI-Pg; Wed, 07 Oct 2026 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEQI4-0004Ph-FJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEQI2-0008UT-9T
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791374308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1rC+cfES8DtkHmWwjIXznMv3tUKUDNyvDkQBxlU6Ds=;
 b=AlPrDK8nFVhxcjji//Mlh5Sr3EjZm2+zduWxMi1frOY3EZ5+AvNRCYkXtIvN3xVjmOxae3
 N5EguocURt+U0vQ3LU0vtmNhEkZJDg3DQfopQfVpqsvnanR7g1AUIdvsE2Lvb6u00HxvF/
 G0Ici1qpEc15CfNXrCxVF/sAgT1j6CU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-uv98HoBkNdaLgPz9BDohyQ-1; Wed, 07 Oct 2026 07:58:27 -0400
X-MC-Unique: uv98HoBkNdaLgPz9BDohyQ-1
X-Mimecast-MFC-AGG-ID: uv98HoBkNdaLgPz9BDohyQ_1791374307
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53395d51187so66021271cf.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791374307; x=1791979107; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t1rC+cfES8DtkHmWwjIXznMv3tUKUDNyvDkQBxlU6Ds=;
 b=GTmj9bsOQ8d/zq+Zcf+CRD1ckgcGtzvxUlodzmjhlGh3/yOWNpGNRZukkLK8uEx/ek
 BFDm5zkpBkQxlLeIAlU0CeNf2kH23KK9Us03QEP5stH+XGFOpdN8Qev8DYWAwFAbK62t
 T+ZbhnlWPso+CfYXg66giQBPn2qsG/FylCAwxjym+U3YdC7L0+8Hq/kBpL5MT3EDJVBI
 aKvvz/ju0LAXa8UGlTCK966/WJrsxI0XXwg8DYv9RqZUNFKyWFEEycNNVV5FfKsJDUpj
 mZGIwcsYZ26JX4TiQ5E0cqS1XAOU+GpcTagAoshTwKWeXf+0cG3T61hELnebgbvOM/tF
 +Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374307; x=1791979107;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t1rC+cfES8DtkHmWwjIXznMv3tUKUDNyvDkQBxlU6Ds=;
 b=RSfhdCYP4mNPQS6yihxztjz/WX8KYMl7rIZGa6azsvqIsWhZs0Fvv5f4FneR16HbhI
 YS6uy0A40ou8CrCeUPE6CfElv0iNXPUjVSo94CPEqDmeYJ/lLEgYdDf1Y8SuuMw6Axlz
 U9KsjcIyUuajbu9X8D+bKlUUImi5497gyPuii3iWuOACeEmq1F+8/eBEi+DWrIkF2kyq
 S6u/p7pUAAabj/qvdcSPS7jltbQ1YPuLi0Ii7If3sIWSs4xHXvYI+fIfNB7BXzEob+Mt
 iu4pqbr62jjMeCLcAsSP6ht/5x/p+WjGFLvNPSKNNqLvfdt1Ac/2ZjPO3+cBWk1UI/U/
 cscQ==
X-Gm-Message-State: AFuF++k/qMnzK0hN037lg8GWtDL4SdT1MD9mocTCfN4UIBKMcn/krWYL
 LK5Btsww0NKHsGUa+5550ZJYsiDYjwND71YkaaYLDlCmDa9ic2w39tMTx+8DUwKStXayEm0T99E
 CgUTiQjxqPS9+jzf9KfaKRZGbpBN7WIozF2TukuxEKFgkByTtMxzTLh06
X-Gm-Gg: AYBFou36aGipEls+eo5va+YayyrpyB8pq5sEuEdFT3Cpom2OZrwqpzXOb5KTRTONFdy
 3ImQiDGJubheu5FsT80s6HYK6i8cDN0v1Tp40m9sXTDxyl9H7gnRcML/qn47sj2Wo0yhNOPkrOy
 7NSdkX5QMxHRsiU+Zw/9c47wojuH24kG+pFaU7IIcDhDjWYpZlOzFGbBkGhBuRYoXj8Cq/6GrHv
 vqmrkcbHqYY84xdzYRc99hLMR6/06WxeFfV9r5pneS8Q8IkziGSJpr22nkLWGG+MVp5CGmz6avY
 AjwsYyaw4MWOMeNLl+F9goBpkR2KOnB7Ok+Yk4GoUSRa+33fOkw8V1AwS0YQCQh+tTlQb2M=
X-Received: by 2002:a05:622a:1191:b0:535:70c5:d40 with SMTP id
 d75a77b69052e-535756c0c66mr33083631cf.69.1791374306695; 
 Wed, 07 Oct 2026 04:58:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1191:b0:535:70c5:d40 with SMTP id
 d75a77b69052e-535756c0c66mr33082211cf.69.1791374303934; 
 Wed, 07 Oct 2026 04:58:23 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53572163ceesm18038441cf.20.2026.10.07.04.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:58:22 -0700 (PDT)
Date: Wed, 7 Oct 2026 07:58:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, dwmw2@infradead.org, mst@redhat.com,
 vsementsov@yandex-team.ru, farosas@suse.de, dongli.zhang@oracle.com,
 den@openvz.org, mark.kanda@oracle.com, sgarzare@redhat.com,
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
Subject: Re: [PATCH v14 16/22] migration: add MIG_EVENT_INCOMING_FAILED
Message-ID: <asYz3UgiMu5VB6FY@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
 <20261007-up-vsock-vhost-v5-v14-16-e16de9962df0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-16-e16de9962df0@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Wed, Oct 07, 2026 at 11:40:09AM +0300, Andrey Drobyshev wrote:
> A device may take over a resource from the source in post_load(), e.g.
> vhost-vsock acquires the device ownership on a CPR target.  If the
> incoming migration fails afterwards, there's currently no way for the
> device to give that resource back before the failure is published, i.e.
> before the source is told about it over the return path and resumes, or
> the management sees the MIGRATION event on the target and resumes the
> source, or the target exits.
> 
> Add a migration event for that, sent to the migration notifiers from
> the failure path of process_incoming_migration_co() before the failure
> is published.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


