Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9BCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7mB-0007Ac-7L; Wed, 27 May 2026 02:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wS7m5-00078f-5b
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wS7m3-0007ud-7R
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779863389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JExJPPFLzVkYK23Ymb0qqNKDhD/YOhK6O4Mtx8xPHYI=;
 b=D4pHWbx1/eRPxNk+xE2V+YPjd6FMRKzjg5HNMlKtF2BKzdEDBJYlB0QpcN3oEvRpGI/GGe
 FLJa5huS0pCltt/u0fLt6jZEUnTASTdfIgFByAQQSh2ZucK7BOYqRVbd6+7fkoj+Ybq9O5
 1mDc5W9d/bCe90vbXcWm5NoE1Xj2kCE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Q55RYU_IN5aye_GVMNjk5Q-1; Wed, 27 May 2026 02:29:47 -0400
X-MC-Unique: Q55RYU_IN5aye_GVMNjk5Q-1
X-Mimecast-MFC-AGG-ID: Q55RYU_IN5aye_GVMNjk5Q_1779863386
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44f1b4d0fb0so7002345f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779863386; x=1780468186; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JExJPPFLzVkYK23Ymb0qqNKDhD/YOhK6O4Mtx8xPHYI=;
 b=Fjtm8QGtZJNsrxhe40xgCXBVfsV7NqtPSkRILZ3kbCVI0vqQEPA/j6kPO49H7m5SwC
 jxjkz4lKedDOhVt2U6p5FhFAzIQ0aBLcXjovaZEBwNpIvQ0a74ABVmZSaBvDmiMCtexr
 gPzfiYIsGBuWsajsRZyPp/TWFOu3IqULu9zt08so8fGR9gvvAL+mA2FfFUewWLTxo/uN
 hxA451WdzvcyPZQrreRiklzOHqZ1MSPZEpOzB0EK0nJ1K6uswCAGK1t9xKRh2v6Ip3OB
 EjvJgEYJF5tWuM5Og+yXGSXg2qWtDjzmFtwTC0g3qLTfGtC9N4azfRYCS1Zc1Guf3S9L
 9hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779863386; x=1780468186;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JExJPPFLzVkYK23Ymb0qqNKDhD/YOhK6O4Mtx8xPHYI=;
 b=Kt/KkZtx/14Ev34x+MPZiWe1FSsA/KlDvNT7b3co9le1ml8gXQMusYyd9zV+IhyjJh
 qLrHSTP54u9BWH9uhhAme6pz+v36G/ihcFDJHjrpItSKiMTGzvK4qv5oN707/iD3C6gM
 J5i0OFV1b7o/jEryadlS0TTLWrljsAWxUnmlKJ1NcsNuy1B4APe/Laf+W4lnR31Syopc
 1FQ3MwpLirn+GL1o85Yr1H7Oh8lnh5AZey7V+c+VywVGNChFZTzc9+1aJ8SEC42Su4hG
 F8d5Y09TByvPkntR2o/Tg7n7SSV9OnUsNJuw5DI3/fvimRq68jY0fZbh5AV1wAi7wLXt
 s++g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F++BTqGh2O5dRpBG3iTerhbEPfiOZcVC0ThuTT22FuvFrrlCXuiUAv2aND/OR7bG8tguQiMq/IB2i@nongnu.org
X-Gm-Message-State: AOJu0YxqlWcro6bzCZkLOelCFnzhtlydhXQPXLbO66wDKLMPYnTmHKjq
 yaUu5xZJEU5SEotOWMonksr3Y9wNQx9cmDC4ncMdzpCjtf/N4UFxIBJM+y9Cy3ZgapjnVUJFhkD
 7Y2778OdeOf92D0/I5ej1p0QWJ/KKmnLo4QnC+65nI0RqgycBL42GiCRw
X-Gm-Gg: Acq92OGSRWD3r4V+EEu9B8ZVM1oDXv8zezCVsQ77WXagnQ4z3DMZ3K6xEhEWnApjkNY
 yeePXfpzdbIUi1uuQbzC5TucTdp+GQGcu7rlNPjtwJKOZAuprIsC5eFNQjryde8LWvXSNIbUdlg
 Oc2QiU76DEYXb5wcIiTkPSlJOnKvzHj0IwAUAqDVvMRE3HAw/oM7WiIOjTJyEEb9ojwPmtYKVl1
 PPa26ulc8kWDzwd8TBf+mQ3IMnRwMJo6g562+cxvCjbR+hH524Ye58tfL/Rn/OAk0ksaU1neIzT
 K0sPAPLVkvKRWHhaao3V6BvhUzcU30IqEtrXPUp72hRAYxpQ1Oww1cD3uoULHX90uY0trjK3dB7
 pWGJHwJ0NuqxFLaGe3vFEjSBFKJMeiQgbyKx3to8wrUvQx4uvq+TBQPrpwXM+HBA2ImPdtbg=
X-Received: by 2002:a05:6000:1447:b0:452:d03a:7abe with SMTP id
 ffacd0b85a97d-45eb38b91c3mr38816069f8f.17.1779863386122; 
 Tue, 26 May 2026 23:29:46 -0700 (PDT)
X-Received: by 2002:a05:6000:1447:b0:452:d03a:7abe with SMTP id
 ffacd0b85a97d-45eb38b91c3mr38816017f8f.17.1779863385730; 
 Tue, 26 May 2026 23:29:45 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54959bsm4149286f8f.1.2026.05.26.23.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 23:29:45 -0700 (PDT)
Date: Wed, 27 May 2026 08:29:44 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 17/18] arm-qmp-cmds: introspection for ID register props
In-Reply-To: <20260519132905.145643-18-eric.auger@redhat.com>
Message-ID: <10ae56f5-6fc7-fe58-1e17-7c3b968045be@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-18-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, 19 May 2026, Eric Auger wrote:
> From: Cornelia Huck <cohuck@redhat.com>
>
> Implement the capability to query available ID register values by
> adding SYSREG_* options and values to the cpu model expansion for the
> host model, if available.
>
> Excerpt:
> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
> {"return": {"model": {"name": "host", "props":
> {"SYSREG_ID_AA64PFR0_EL1_EL3": 1224979098931106066,
 				 ^
This looks wrong - more like the full reg value and not just EL3..

> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
> ../..
>
> So this allows the upper stack to detect available writable ID
> regs and the "host passthrough model" values.
>
> [CH: moved SYSREG_* values to host model]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


