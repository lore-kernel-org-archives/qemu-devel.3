Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3237CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKNa-0000Ho-Tw; Thu, 15 Oct 2026 08:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNV-0000G0-AL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHKNT-0004L6-AD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sTMsb3Bfql/0FLz+rxdR8x6dp5dTWCNKP8OZlMF384=;
 b=eIF5t1Tb5awf/zqHghyLTmW28gZgwtY3BT6NJFgNSufUM2kN/RrXediqPL/MvMMz8Ro/e6
 keGr8erGrmnv1oVlcDGO8RXope1GPkbbpLXixfZnsPye/xboYSdjds5QyP3OlsoOqezduP
 kw1v690u6yGVcFlkI6lOu6P8q3hEudE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-vFKl8_75PkitRaCx4b7Dgw-1; Thu,
 15 Oct 2026 12:16:03 +0000
X-MC-Unique: vFKl8_75PkitRaCx4b7Dgw-1
X-Mimecast-MFC-AGG-ID: vFKl8_75PkitRaCx4b7Dgw_1792066562
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5CB1180036E; Thu, 15 Oct 2026 12:16:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42D5F1956087; Thu, 15 Oct 2026 12:15:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
Date: Thu, 15 Oct 2026 16:15:52 +0400
Message-Id: <179206655287.744241.865023521920859070.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MM+KQis/UkweKLiF5YomJxgBt8nBi4y5nV98wrnYApc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0MP8zZCcFQjk1AwUM7oofiq8jdh207ucaQcz5
 gMspA7pRj6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatDD/AAKCRDa6OEJdZac
 5b76D/9QPYaI9aKwn7RMzAQqTAhN3Xswh2DjB0Cn5BemVlgKOJF5jqpVfgr8sCb7S1Ubrpn+Nrx
 nTgN3g91jibkWHORDaUCNN2omDBDWJ404Iwj4jNwsrT0rSlMxfM+AxbaR0Hk1jVq1EfCENMmHcn
 7ZVAEbzNbavbqhDnKugb/sf0Bc2tpDwuTAEnMOJ52+05dFi74/63j+hMwGRapuyeMj3uErDZf2W
 SIQeC1jio7DEjb++P/pVU3qFrw9Tn9R/Ow1cSFsW83BUA1ogQ6NkbfBl5HJAQwmCTuXebxXrPay
 4Ru8LDaS1VHJ1Alwbn9dBWOEM/P0lOZJmOUavvFJ4Qrj+L5LxzNpbi6EjGILfItYE/xEf4jXSOV
 +AxY3U2Qqg8GEPpRnrWJbyRvbiVTd08eLD9xEdolIwzwro4lOQ7nuYPxab+U0uO6XesUTs/NvlD
 plWnH/nSPchCJQ9AdUmQ9oLXPWqqbRabClJG/I5h4uz7xy+o87vndjg/+FtDTpNkl/jtsSa+sDA
 DiXQDNd40p+SprNiXnh/TlhsPdw/eLXUC1bq2chTemxdDNIlgx1IGqiS/zca0ABUdKV7wOx5zCM
 JAhKJgixnV0Fd1jHiC5K/iXGNCor2ixiFDl3qIiAxqxwHMbPlJvbEl2KBgf4Z0eWAc/1HBX4iXF
 zZoEqIJOQy7KNmg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

> This series introduces a new facility called 'tldr' which is a
> live data recorder. This is intended to aid support of production
> QEMU deployments, by providing a data collection facility that
> can be left "always on", such that in the event of a QEMU crash
> or guest OS crash, certain important information will be recorded.
> 
> The data recorder has to be enabled by adding a "tldr-config"
> object instance with -object / object_add.
> 
> With this series, the data recorder collects
> 
>  * error_report/warn_report/error_printf messages
>  * QMP events

It should probably be recorded at emission, not per monitor

>  * QMP errors
>  * QMP commands, which are not query-XXX/qom-list,
>    or any command associated with a QMP error.
>  * qemu_log output
> 
> The last item is intended primarily to be used in combination
> with tracing and its 'log' backend, to have continuous
> recording of certain interesting probes.
> 
> Each type of data is collected in a distinct circular
> buffer, such that high volumes of one type of data, does
> not result in overwriting other types of low volume data.
> 
> The data recorder is set to trigger on SIGBUS, SIGSEGV,
> SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.

Instead of allocating and dumping by a signal handler, why not use a file-backed
mmap or a memfd? We would need to define a small fixed header for the file
layout/buckets.  This would avoid all the issues with signal handlers.

There would be a small window for consistency on crash, but that's probably
acceptable.

Plain ASCII section markers would probably be easier to deal with than emojis

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


