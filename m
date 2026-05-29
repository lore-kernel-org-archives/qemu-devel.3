Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D79FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAv-0007QL-Rd; Fri, 29 May 2026 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSyAu-0007Mq-Ar
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSyAs-0003SK-GD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780064816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaJTMVAmH26lSWG70NhalIKmAZavB1f0w8qBDPlsqd0=;
 b=DJG4VAP5ls9vPmHomoNaIpO8u6YPdE7g+DeGgPG8YElQ2i63eZM8FqTgxELeJ0+yVIJROS
 IRvhskGzOkOMH0udW5F+BV2Ku/mZR+WXdoWViY6SJvrraS0nByEK3JkseesD4IujEOeiJw
 5BHPCEacUvz8MQ58X7slrrETc+/B4EY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-VGLGvUpGPeKLB91Lsme9JQ-1; Fri, 29 May 2026 10:26:54 -0400
X-MC-Unique: VGLGvUpGPeKLB91Lsme9JQ-1
X-Mimecast-MFC-AGG-ID: VGLGvUpGPeKLB91Lsme9JQ_1780064814
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914b616c788so1181109585a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780064814; x=1780669614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IaJTMVAmH26lSWG70NhalIKmAZavB1f0w8qBDPlsqd0=;
 b=mOFNgBwzr7ZWfN+/FabGPsxNjsIZaOh6UXjyfQ9xppo8FYQcx47JhCSsAiNisyTL9j
 Ii3Kk5w+016Y480Mu0qrwtnbK7+/tI8kBUN/5hIwtsGlcCGtJEbAzzfRWnoAD9uX3dx4
 QAHZNkTjA3SLuHzgVeixA/E6dKMapkadFMdyuCRyF2N8F6x9N7/2rJ9RpWFPkgT4R2U0
 grm29gIvamHPmWuvLz78SYV68LjOQv9Z6g+72uVYW+6+YqP4ATFy6U2p7ARsfR4+nA8l
 wOi0jq+ipqHRYCFt2zIsJ/fi3qmcaT4i18NUToBY9uDpf/GzIyqqWgKS+fi1CDC0BDgG
 7+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064814; x=1780669614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaJTMVAmH26lSWG70NhalIKmAZavB1f0w8qBDPlsqd0=;
 b=lmKhGGI6jLFyWENFNzbNR4nOpy5Tb9RxuOamPmrYhRdq/vXsJ3DxHsrWkPQD3rxfDy
 AFMy2H2UkJ7NMkwUV3ZZ8nNysyKO+P1J9GrIg6m44K4Qia773sLnPmOeoLA+ZH+QJOcm
 cWX0nMiKfFI49cWr6wg3ZWBanMQpEdsFa3j/Jfes8mg0Aodo7LKzKxTfMDJCGJ7qg3L7
 NBXrdN7XfwQ7gx3X+o8+xWpJCKtzXRnYEt2beP2a8hyYGzXJPdDGjB3XDmOI+xfZV5rU
 8SmcQUSKnm0GTPqRqKwRmp61mUsVMX/l50x5DCOaPCmRl4XkK6q2CRrryjvHDTEiJt9s
 HiCg==
X-Gm-Message-State: AOJu0Yw7vzfG7w1EsKOGhbI+5Gvnx5Psnr4vWSllBH6+d31V+d6sn5dr
 B/2ugSSEo2LfqBT+SdpGR/fFk87k8wRmPyBcCVHSQATKBGNgeSz8ifetEhRDXyBKwQ2jTPI1FAH
 eak9KWfrASVTYH0tfXw6dsrd2GshrV5O+/WU+1919BcZ0OVubu5P2csiP
X-Gm-Gg: Acq92OHlrWHcW5AiXKYjnumn0yThpkO6cA1CINjw6VMbs3e3cFZ0SomTg2noaeHkRrM
 l8rbAZDNc+C6M7BxuuWDicSI6mztW6vO6pp4/nQ0KgJmjKcWpaxYFaTvnJZfwsCavXtBfFpOluc
 0gxflRBalAqOgylUKk76/YQSMJMgBPGS60OdEd6bo3tc8Iz9BofwcPUsBj0R3rCSfVWkmwqMyYn
 hAaPVTloYz3rMCuXcs2MhtEXuKVdk5Nj9HVKxXS1evkB9YvEbTvDY7QfhxGTAab9hopRSQuqORA
 KZRhJZvMyRgp9BmPBaI/F2zNsYZbELbcztXmkv4WrCnA9XoKVp8GmHPwRBkQl6eto0jXcNJSjZX
 rrzvUDrW68yYCfToE0Ooj4LfEMA/0rWqKvFotkG9cneVTmbNSqmFWVwq+eg==
X-Received: by 2002:a05:620a:1995:b0:909:c82b:9756 with SMTP id
 af79cd13be357-9152fcd2f88mr403592485a.5.1780064813809; 
 Fri, 29 May 2026 07:26:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1995:b0:909:c82b:9756 with SMTP id
 af79cd13be357-9152fcd2f88mr403584885a.5.1780064813035; 
 Fri, 29 May 2026 07:26:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9153265d7f2sm193280185a.43.2026.05.29.07.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:26:52 -0700 (PDT)
Date: Fri, 29 May 2026 10:26:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <ahmiKxc0swrIJQVB@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <0166334e-6a34-4fb4-b7c3-300ec2b8b07f@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0166334e-6a34-4fb4-b7c3-300ec2b8b07f@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, May 29, 2026 at 10:26:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 29.05.26 00:29, Peter Xu wrote:
> > QEMU doesn't yet have a good way to specify migration parameters so that
> > they can be available even during early stage of QEMU boots.  It is because
> > the migration object (who owns the migration parameters) will only be
> > created after PHASE_LATE_BACKENDS_CREATED.  It means anything before it
> > reading migration parameters is illegal.
> 
> But with this series, we actually do create a part of this migration object,
> which is created earlier.
> 
> Is it possible instead to initialize the whole migration object earlier?
> Or maybe, somehow "partly" initialize it (if full initialization is not
> possible for some reasons), but still keep one object, without external
> part, stored in separate global variable?

It needs to be there because migration object currently depends on machine
compat properties to apply some parameters on top, see:

$ git grep "\"migration\"" hw/core/machine.c
hw/core/machine.c:    { "migration", "multifd-clean-tls-termination", "false" },
hw/core/machine.c:    { "migration", "send-switchover-start", "off"},
hw/core/machine.c:    { "migration", "zero-page-detection", "legacy"},
hw/core/machine.c:    { "migration", "multifd-flush-after-each-section", "on"},
hw/core/machine.c:    { "migration", "x-preempt-pre-7-2", "true" },

While machine compat properties are initialized in different phases.  The
one we really depend on (per above) is qemu_create_machine(), where
object_set_machine_compat_props() updates object_compat_props[1].

Logically it's fully initialized after all three entries updated, which
means we'd better initialize migration objects after at least
configure_accelerators() which updates object_compat_props[2]..

-- 
Peter Xu


