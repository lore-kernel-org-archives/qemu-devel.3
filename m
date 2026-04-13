Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA02F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGnl-0001wk-8y; Mon, 13 Apr 2026 08:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wCGnj-0001wc-Gt
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wCGni-0001xj-4J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776084840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=IWNhoZxs3J/mjkA0Co90zvy2C4G9vu2HdsRKdktW2INujyV0pyI3OZXWejf5NwJ08XJKGz
 XK16yEpTqZMlQTBuQfpUxhVGBnvlBLa/3aOMGwszl8HiI6BdfjSE3p4k0UuW6lHoCWppct
 WtoFdryrUnsAkF0/PGJ0d8M+NqSt60c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-KJckuX2MOI2z4bKpHfEV5g-1; Mon, 13 Apr 2026 08:53:57 -0400
X-MC-Unique: KJckuX2MOI2z4bKpHfEV5g-1
X-Mimecast-MFC-AGG-ID: KJckuX2MOI2z4bKpHfEV5g_1776084836
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c768a9a9so22022635e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776084836; x=1776689636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JTfOzWdzyQRMoQLHI2llx4ndYKL8zzpilumfN6cxXRtxiqGez2ZpMSnzJZjsv71u9L
 Wo0F0tlluJy2qYsiMTb4BKKeR5aXiNbLyXMo+tPjbmIHEYgsr4dDhzR+6ClJQ7JkJ2sq
 ACDlnHhAGE4rHqgf34fnB6zbg2AGMfOZScHLORcdnF9ooB4lfid9RoVVP9CVz9Gm7/nj
 o2tUIajBoGJIhyq9PwS0Vywg4YzW/cgz5FdGPknbz9njIGt61UtNJF6qWvlDA+sxLCzI
 MZfCcqZ0/flMtmGQyxhZR5dwpxZdGEk6rE4spCwPbIXGgJxMMXYGwtEDAIXgFk7ro6q9
 S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776084836; x=1776689636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eRY6gykxfqNDTZRKViOhYZbFPdmLFvfVNCpVSuf1ok4R+IyBLsCdU4+qm7lfcetryn
 4yFTGf6GVk6+5LFvtJibQeDVY8WWcK7Ftig5JlvkTu0ua4y4L44A+CQB30qYfqTT6GmF
 F4RhIj14M91EWK19Bco60zp2UH0mgUJppXe58NzGH2nIuEVh0K91g9UROqeNN2gobsb4
 sIgQMWWxwqFHK5xSEAHAwvZxm9Q7EpQk6mzc9eN2N984jUhSxVfkP66wMNNvlJjE0IlN
 m+ehKHpPhsBuk+avUxsEf7NljxxV/2LcU9GKMDYWI/F3y92D4lXa/C3htrGRPbk92UYY
 1STw==
X-Gm-Message-State: AOJu0YyPxbpbgTybP2G2yadI6w61/em3XFq4BMwCw2Fbj6+Kz+c81nNY
 +3v7vBtCeH/3iGL2QN49nSgyH03hjWrkBYS/GfhrtO/iiv3R9GunbOZyFmr6ALpjq6gA+JCYHoq
 hEAple+wdm1V/hVjLHAn7Nwo37diDlUaRHIvxQNscyUmc3SMGRgEcctTy
X-Gm-Gg: AeBDieuhqf7lopXbr4bvYlzmUdwpZcgepPXqgvoMYbWECCLgsSwTALqpab2UBja+8+4
 7FqcKBsQBnlBMS+Y1KEOxds5VZOqfIKHTMW5Gl5npt4DVZZGrcAylNgNO8sRVC/+4eaML6vLBFS
 JVAJCeOOmd8n49bQjTGdFsgwVXDlNAt5qXe7kTtXfuStoBQ5FFN0RaR1qk+Y2M/GwSvpFsXqnlo
 K6yArr2l4H86QepL2IdQIdKZPx7kVJ5UOgqG4nvKy6tFyi/hciQUKgSA4e1Vwq8P5NXuOjdbhdA
 FtAV5iUitk6QU5qubr1/3T5aLCmeO2pV9YRunEhwa+VJnNXxqXXCerOy/AtdVjMYVq8eUuk2Axg
 nYslXEu6TuRHQafawG1uqME5z0pPU45t0gAthuFKJGalEYqGOZPL3IOfG/89HKgt/LalR+ztaO2
 gjgbY8x0zt6lmHSxNZSbUVncjw
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488d68af17bmr148918595e9.16.1776084835911; 
 Mon, 13 Apr 2026 05:53:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488d68af17bmr148918255e9.16.1776084835448; 
 Mon, 13 Apr 2026 05:53:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3cbb2sm307121975e9.13.2026.04.13.05.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:53:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] target/i386: fix strList leak in
 x86_cpu_get_unavailable_features
Date: Mon, 13 Apr 2026 14:53:53 +0200
Message-ID: <20260413125353.249462-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413125040.3842686-1-marcandre.lureau@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


