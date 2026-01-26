Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5529D13C34
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOVx-0007yh-GP; Mon, 26 Jan 2026 10:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkOVt-0007yD-DA
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkOVq-00070A-14
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769441301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NECZZXVUiYuXNskmOEAwlBsTm/1VXEAWO3picQtdQgw=;
 b=JCAz32vMLQVpR1kS48cgu2VPUlwC0TGjOs/lW6ZG2Ar6WsAqMsnfTk6wDte4NphTLB1m0i
 N2pmmMDNDZa+NqU6sU06I/VGzDJQROc9siXyuIXQhq5K50PUUALMgfkGfUM3BlRiZlsDil
 zMPUnePaNKNzpz8vSzQ1ddOq86Jc/TM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-p2U48yUNODCl408CVcdH3w-1; Mon, 26 Jan 2026 10:28:19 -0500
X-MC-Unique: p2U48yUNODCl408CVcdH3w-1
X-Mimecast-MFC-AGG-ID: p2U48yUNODCl408CVcdH3w_1769441299
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a2ea47fa5so130330836d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769441299; x=1770046099; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NECZZXVUiYuXNskmOEAwlBsTm/1VXEAWO3picQtdQgw=;
 b=mH6LuL0Qk5iR5SecEyQyn2BHJpczP0ZoJjrO2OUGDKgSaJVuTKuYpToyzYvPVDh8MU
 aHbfJ6A2RMSWNYSIdZlqco836LwMruAESZTYtSv59j98irmlG4VtmD1PplhKv/BLjyF3
 RYO3jVWGuweAAbsKTg3ULHWxQ05icegE76J3y72JcwAAqHKnjq4rSvMC8/SdFuxOpbHh
 S4r/lh7Jd+1HcaxOtuPD7hoG0wFycLHCofL5qa3NN9uaTmsudOonJ02KvVrKE6Chn5+T
 LyYCQT+NPDtzYkUOtZ2JQq8FlltLvfii7rak0rQ7ydLRfH1Bw3OijDnNorXk7fzJQTfK
 XrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769441299; x=1770046099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NECZZXVUiYuXNskmOEAwlBsTm/1VXEAWO3picQtdQgw=;
 b=FOAMvsW8MEWlbNRC35uChOj+qWioqFvyW7J28YZeIAT/uBAb9hhEkKicM5WLoOQEM6
 5ohmLpMzzXMmH+pYqlZKVmDA4oSY+0OwSq+YxljeNzgMhmTAuDEoBJDBNVjleUZDxnrK
 SkkunSJev5+f3ewgCN183i+6xzByc4dIKq81YbM+AvbBkQAhCRiPxGnOV8NAggpcljkN
 hiHFsEdtjUXO3WbYzrLTpkWZz3Um4v6/mpKHq+7o1xelhn6BrBQamEPQWsH42MNPmYYK
 cOIZE3F8ih7M5dHtcTxrbD+hbdFpsdZCwMmiaHIoeqqlTNmuH7LjLPEm8aMwxObKZpSU
 zo4Q==
X-Gm-Message-State: AOJu0YyQLCuG46ZLy+ShqXx9sg+FZ9flrOn1ZGbDAO6JLBYPwTl0qyoC
 OlUfb2dQMFtjA032Ecju6ggPmzpgSXS4hCazvAegZ7stkG9gMqK0/xF7H7igflaJ9xr0UxVs3lI
 D+yKr4iRcXSiCsXvuuzzGhzJjo0U0JhDVLXJjaUStYwlhlkxq347Rnar1
X-Gm-Gg: AZuq6aLB+ikozSzNnOPhwApoFukpPQLI6wYCyZFgqvIuARWVtrgFve6ii8QMGU5GBY5
 c980gMxMdjPok2cB1a1cUfgMhpLxmu0Bu3F0ww+EgmdOI+PIJBMhd1kPHs/1+L0mUHkbBGB6Om2
 IUNluGFaOl1jpRdLJgcNb8TwdIZkUvtayAp2wMSr56XAJ3XaYZoMfhDS9LYdfKzie+BKGlKP8Dz
 d+PIo1M14b2keiKsSj4G+Ns+t22zsJQJjJp/YPsYQr85+3gcTURlhsM+1dbabHw7Mtp9kA+tgkx
 64ddTHj47ZZirMUjcmgt9HSIaGunjmuyvJ2zMg+yRIJfU9osIaNw33G3hrwIE+1zjlRhwxqhtXU
 74JI=
X-Received: by 2002:a05:6214:258d:b0:88a:2d2c:3b4 with SMTP id
 6a1803df08f44-894b04bd85fmr72728756d6.29.1769441298671; 
 Mon, 26 Jan 2026 07:28:18 -0800 (PST)
X-Received: by 2002:a05:6214:258d:b0:88a:2d2c:3b4 with SMTP id
 6a1803df08f44-894b04bd85fmr72728036d6.29.1769441298010; 
 Mon, 26 Jan 2026 07:28:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894935d08c1sm111412676d6.5.2026.01.26.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:28:17 -0800 (PST)
Date: Mon, 26 Jan 2026 10:28:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 5/8] migration-test: Add COLO migration unit test
Message-ID: <aXeIEDrHRwtdKiPO@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-5-ab521777fa51@web.de>
 <aW-5_BtdDDLw3ZJH@x1.local> <20260121203751.6bc9027d@penguin>
 <20260125181836.3dd2d026@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260125181836.3dd2d026@penguin>
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

On Sun, Jan 25, 2026 at 06:18:36PM +0100, Lukas Straub wrote:
> On Wed, 21 Jan 2026 20:37:51 +0100
> Lukas Straub <lukasstraub2@web.de> wrote:
> 
> > On Tue, 20 Jan 2026 12:23:08 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> > 
> > > On Sat, Jan 17, 2026 at 03:09:12PM +0100, Lukas Straub wrote:  
> > > > Add a COLO migration test for COLO migration and failover.
> > > > 
> > > > COLO does not support q35 machine at this time.
> > > > 
> > > > [...]
> > > >  
> > > > +int test_colo_common(MigrateCommon *args, bool failover_during_checkpoint,
> > > > +                     bool primary_failover)
> > > > +{
> > > > +    QTestState *from, *to;
> > > > +    void *data_hook = NULL;
> > > > +
> > > > +    /*
> > > > +     * For the COLO test, both VMs will run in parallel. Thus both VMs want to
> > > > +     * open the image read/write at the same time. Using read-only=on is not
> > > > +     * possible here, because ide-hd does not support read-only backing image.
> > > > +     *
> > > > +     * So use -snapshot, where each qemu instance creates its own writable
> > > > +     * snapshot internally while leaving the real image read-only.
> > > > +     */
> > > > +    args->start.opts_source = "-snapshot";
> > > > +    args->start.opts_target = "-snapshot";
> > > > +
> > > > +    /*
> > > > +     * COLO migration code logs many errors when the migration socket
> > > > +     * is shut down, these are expected so we hide them here.
> > > > +     */
> > > > +    args->start.hide_stderr = true;
> > > > +
> > > > +    /*
> > > > +     * COLO currently does not work with Q35 machine
> > > > +     */
> > > > +    args->start.force_pc_machine = true;
> > > > +
> > > > +    args->start.oob = true;    
> > > 
> > > Just curious: is OOB required in COLO for some reason?  I understand yank
> > > you used below uses OOB, so the question is behind that, on what can be
> > > blocked in main thread, and special in COLO.
> 
> There is a lot that can hang:
> The netfilters all run on the main loop and use blocking write.
> fiter-mirror on the primary side mirrors packets to the secondary and
> can hang.
> filter-redirect on the secondary side redirects packets to primary's
> colo-compare and can hang.
> The nbd client on the primary side that is connected to the nbd server
> on the secondary side can hang. Especially during vm_stop() which fluses
> all inflight block io with BQL held.

None of them are used in this unit test, right?

I agree if OOB is needed in production we should also enable it in the unit
tests.  Said that, would you please add a comment into the test case
explaining this?  E.g. what can fail in reality, and why we still test OOB
(because we want to get as close to production COLO use case as possible).

Thanks,

-- 
Peter Xu


