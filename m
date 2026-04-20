Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65185F588EA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEqzT-0007cw-Dj; Mon, 20 Apr 2026 11:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEqzR-0007c4-OP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEqzO-0006RH-Rp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 11:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776700603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJylDB9g0jgHglk1zn+MseCq+mrZzuqa1vC7EIiJfUU=;
 b=g5MxW3PkXIzFLomFLmiIQLS34d+11+27dTfkwWqQTyjNLyKwjCfL6srqhJkvVrOCoCta2p
 S8TDjWUEEH4fTG8ugGo00kI4CWhCjFutgEn3554HULyH6bo4IfwY0IvY9hynEIGsOTSec5
 VznUKdCozKcrCHc0mimhEL571Mg5pdo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-TE3reGD6M5-3jXdVGr6b8g-1; Mon, 20 Apr 2026 11:56:42 -0400
X-MC-Unique: TE3reGD6M5-3jXdVGr6b8g-1
X-Mimecast-MFC-AGG-ID: TE3reGD6M5-3jXdVGr6b8g_1776700602
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8ece46c4ba9so83100785a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776700602; x=1777305402; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oJylDB9g0jgHglk1zn+MseCq+mrZzuqa1vC7EIiJfUU=;
 b=V2U9XwYMWF5WDZJYNwjuBSas98i595MtiKSuj5WXccN+lgM9bUPDtsrZeTBlF4s/KU
 YUEzJ9DZlez2wqaYU6kUrDwsfzYY4tkKub6N1f+KkfSPKbUjegtnC6JKLOP5/Hb3eYrk
 nZaw++Z7V1e8MLqxsid7dNU427qBFG9Nulbd49X99kHA6BEwt+hdToIzw++GHtgmXFZS
 ExQ4ndVOw0nNGl4reC2sTJbGdZK6K4SGO29JD2gNEcOXjhCIHzMayhKkLKkW69HFP+yN
 k9SI1VPZnS378gF4cTAf6M3kuVx6FCwOKPT9MuW1MHt5Sj/3by/6MqAOVkHKU+yvuFb8
 1+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776700602; x=1777305402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJylDB9g0jgHglk1zn+MseCq+mrZzuqa1vC7EIiJfUU=;
 b=H5jVBAa5kM1IJpb/VB8zfHXIJwAgVC7J2OBdLPHFzbFs+6zTbx40yhbR89jJd6o+kf
 AoUWepM3FGuaqOyBUTjFR1XJJRKi3/yCAkpwCR+Kk1GGccqyhTClN7sZ2mPcQtS04+Y+
 +JaIG0xSK53W6NYM0X0qQHEZwrSXeIYhonyvIQQMCAPJ1J+BxNBg47JyxbR8YWCzbfaG
 E/RvOkWOtJQUqIQyvGTzoTiEyZ2yHOtDaH5t7c9x8zlS60mramw7Z+JOvU5SEkVzKbas
 7+UomtYrrROUldgfMEjcrAnK4fuHG0iy7JJrGw/OJS8Ps9hzUKhDHDp9BGfLY/udlPQT
 /DmA==
X-Gm-Message-State: AOJu0Yyj1VKTnFBETrZwnNA2p4OMal2Dd/a8rJe4XhZrcwzdINBx7b8Q
 q2BvYhy+d5chYzdGMlCcO8R+anUErqDCDtNcnLRhGvKSZ9+1eszShrEvlVliXefhMc1BCFdZQk8
 sL2r/pYdLYuyiRkeqmyPcPI6m4C0y6xunhTZ0VBcOj+m+33EeTBJz1jhL
X-Gm-Gg: AeBDieuIdUeNVc8N1yZcRglDDpgwh/+i0M1I0wCfW6KqsOPsZo/3Kaw2TCtJXSivmV7
 ruqmHf3OJiRCkUnqDII3InevAy9q36bc555WxnjseyQXCDfekXyuofhzx1IwiJLdA0p0D5vhvqX
 L7snrHIJ1IS+BeyB1+MZqkpSkW0P8Bg/M28kwRvzWukJnEQKSBZcFGM0KCqvm7BAkyfYW+gX3IF
 D6wzs3wJl0QQgjaZqQAPtYuGT1V34e9ML8S96nioXrSOsJJFJdYR3kA0W2RidSlnfcjN98wjl7N
 STWxiTcPfy4KWYBQpQzZ+yqIIuZ7dhyOfMXLyg0YaUMpiGFBQDfagV+Dwvfok+WWYtpo5J/PnM4
 wcYbT05eY503Bh/sUWmq4RBVf3OKitFcpXF+nEjwHHEJuIhgnRO/g1y0j+w==
X-Received: by 2002:a05:620a:4623:b0:8cf:e32e:8a0a with SMTP id
 af79cd13be357-8e79010e523mr2013076585a.18.1776700601625; 
 Mon, 20 Apr 2026 08:56:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:8cf:e32e:8a0a with SMTP id
 af79cd13be357-8e79010e523mr2013070085a.18.1776700601001; 
 Mon, 20 Apr 2026 08:56:41 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edc2b9sm871385185a.23.2026.04.20.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 08:56:40 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:56:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 08/14] migration: Make qemu_savevm_query_pending()
 available anytime
Message-ID: <aeZMtxqrKWAMKzdN@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-9-peterx@redhat.com>
 <adfegWEjLcGmDTPi@fedora> <aeElO8Wkkbqh439l@x1.local>
 <aeIJt7j7BiiwuITG@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeIJt7j7BiiwuITG@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 17, 2026 at 12:26:29PM +0200, Juraj Marcin wrote:
> I agree with your approach, I was just wondering if there are other such
> races that are not handled yet. I don't think anything needs to be
> changed then, given that only save_query_pending() is susceptible to the
> race.

Emmm, irrelevant of what we're discussing.. I overlooked something here.

I just notice save_query_pending() has lock implications, this may not work
to be exported directly to a QMP handler: dirty_bitmap_state_pending(), as
one example, may take BQL inside the query function.

I added some lines into current dirty-bitmap tests, and it can already
reproduce a crash (due to deadlocking on BQL):

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index c519e6db8c..67d69d9d1e 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -162,8 +162,14 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         self.vm_a.cmd('migrate', uri='exec:cat>' + fifo)
 
+        # Verify query-migrate working with dirty-bitmaps in precopy mode
+        self.vm_a.qmp('query-migrate')
+
         self.vm_a.cmd('migrate-start-postcopy')
 
+        # Verify query-migrate working with dirty-bitmaps in postcopy mode
+        self.vm_a.qmp('query-migrate')
+
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
         return (event_resume, discards1_sha256, all_discards_sha256)

I'll need to fix it in another way, I'll think about it.  I'll likely add
above into a separate small patch for qemu iotests to cover this case when
repost.

-- 
Peter Xu


