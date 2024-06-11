Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4468C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0Yu-0003lE-PM; Tue, 11 Jun 2024 08:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH0Yt-0003ka-Bq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH0Yq-0007eO-SE
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718108711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=U905jxUCmuDdb0UWtqph0Lu084jwn8043ojIIIFvrRlQ7KOI6Ht6vu259lcWPH0qIPshSY
 xw8t/XSDzycOcevS8HTmsAOPAfppy0fl0rnvHpKNeoM9SVSgIaXQzqxX/ECUKn3fo6BS7T
 Kk/0OKy+5oAy51YdFihMHR5j5Lu0hAU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-2bv9b2SJPS-3OjReLFWcig-1; Tue, 11 Jun 2024 08:25:10 -0400
X-MC-Unique: 2bv9b2SJPS-3OjReLFWcig-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f2662d050so73168466b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718108709; x=1718713509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=kDVbXluKb0RbGpuwCXeGl9H0e+Q/a5asniFlRB0TBH+bb6cQLbQR8YEWlvx2z7UQCK
 dOxBFU+mtyRGR45M3p/Vuq/eRTuUGCBqoFa3kI9rouf32PqWo93xNH1RSohKqEr8gIG2
 EWy8jE2zRc3U7i/xunilFN9yn1mNVH/qJmbk3F2l/sWeSP04WB9cZ/ljV2hr3Mey9A6M
 gNlYo3Y3s7+np1jBSM4yhJbjbDmhqdzsGUXe0rk9imupJF+yMm3ZDmlHxAklkF52o/Px
 eDHsbMuuT4YUWBKKxFjJMH+LG5MaYMn7rG2BZwHNDMskoV+kpCBadqEhfi0dYk6+cMnv
 j2ZQ==
X-Gm-Message-State: AOJu0YzYo1t1C1wHDUk0VGagFXYz1KsDp6YWYmWq1dAHVCJ7reJIX18v
 5jNmWNb2h4GASV37drJPTUrU4ZY9qAUQN2oiUR77X/t3uWAhuCEttWAAHPZWIRDuuJz1DZVL38t
 8hnX0A3mK2eFmJubaPcPgs0LkiFuc43Ec0XgE5Gu4Tu6xlN2bHpK9
X-Received: by 2002:a17:906:6bc8:b0:a6e:c5b0:b64e with SMTP id
 a640c23a62f3a-a6ec5b0b6e4mr659097166b.9.1718108709476; 
 Tue, 11 Jun 2024 05:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYaGe4czEsAAMGac8seW4pp3tNXx6Y1KehCuw8SlmiUM859MGVqzeB/gSGRnBG7a0v23iP1g==
X-Received: by 2002:a17:906:6bc8:b0:a6e:c5b0:b64e with SMTP id
 a640c23a62f3a-a6ec5b0b6e4mr659095666b.9.1718108709137; 
 Tue, 11 Jun 2024 05:25:09 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1477ca46sm344451166b.113.2024.06.11.05.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:25:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 imammedo@redhat.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
 processor cores in the physical package
Date: Tue, 11 Jun 2024 14:25:05 +0200
Message-ID: <20240611122506.68829-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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


