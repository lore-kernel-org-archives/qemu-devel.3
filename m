Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95CF104BED5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GwD-0007jH-Md; Wed, 11 Mar 2026 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0GwC-0007j6-EK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0GwA-0004Oy-UY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773225429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6UXG4Mgxe1tz7YbglO0WtGRaw5MfIIMfNE+bwZ8iHnU=;
 b=Rp8mR5/+EdwVLwFRPrQGOvotmJx+W2dAmPr9W1h/qne+TAj0e4suIuOlFzfeI78KK7GREe
 fulBWUpGzGStNPKLSSnwuIDCr9Ubj+lKyqYdxGMbE2wC3qeYxa7cGCzc+UdMOj/D+PHxyJ
 YS35WGbu+0m0hsa656svOdiy+WGWkOg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-iQmlr8VePKasbTvXS6Entg-1; Wed, 11 Mar 2026 06:37:08 -0400
X-MC-Unique: iQmlr8VePKasbTvXS6Entg-1
X-Mimecast-MFC-AGG-ID: iQmlr8VePKasbTvXS6Entg_1773225427
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48535f4d5e1so31585805e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225427; cv=none;
 d=google.com; s=arc-20240605;
 b=IcNPdjwavGtrrp72/mcLVAt/blJZmIDFEL6MSyu0EGLXFCBejfb/ggvuQFmZKaWpqV
 9PydYP5Z8gmSMlqncFqnsj2TMRYThPGzTh4lOdDVexB2L7r/XTHoovmCrqa9NJiNj2d/
 VqAF8Sv5P1upWnUMsMcA7o6HzfwyFt+RTFJU3RD2bm/1rF54qJmvr9f7aoiOqsVsou9a
 5QBQeNzdFSpdq8OX6oWBYKZJto4n7ElyMozkoby0eg2t9dvyukNxAv0vladqG6WtRtoD
 TXUGfMT3Y9/TRrjda96XZiPk+smX9vg3F0j2YGbEKuCaQ2QT7m8EAzO9C9apEnzk28Is
 qS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6UXG4Mgxe1tz7YbglO0WtGRaw5MfIIMfNE+bwZ8iHnU=;
 fh=6YWEQ6STaykdDKUSKGpa8TiV7qfgIeD7oqsBXI2Kkd0=;
 b=j6NmLvomB1Fl6NyEEDI+SJ/t2Vg9hIR4PjaIN0vNAwc+uGy0N/wxPBlS9Ap26S0V1u
 6FIdAwNjs7ykJQiYJL4TZfu8U9hCgswL3xZRzl3qnYPpyH//PRnXuDnn2jr+psiEq+5W
 qTeWEfFIPErQW0y9BKzzpOz8Ke30nCj+Surb7PTUUxuYUFR+FM+JcdZWirqCTxwYrcBL
 MRZUrZfTXGocyYu/RUVdaFw8D12VNDrRKFKog2HcCfb6tsE8Lg6DpD+6JjFeBcwPSFGS
 ZzzvjrCf6ZT1qjiHNyLQs/2MygoW3ViKdfKhNLjTGEnQsd0CMO45mXUcyUUqIVJUUeE5
 jqQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773225427; x=1773830227; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6UXG4Mgxe1tz7YbglO0WtGRaw5MfIIMfNE+bwZ8iHnU=;
 b=YcWyWJZJiBdJvEuzw521fQzQ65gmtNYMlR+Z5C54g7wWxoCCPVmiXW1mOfhIWnucBD
 vD9khrJok4Hotcgo1cw1luZVPqfFEXoSTYqG+dE4j97374w0COWVAOnf2tedN5p0O2hY
 rEDeiriserXMS8xloc+9ltAjqxmsMCG6vaczba4TMpJiyb6IG+gzQ9Xn17ez9X9Vyqbx
 54OtG2/l8Ko/yOSmgJO3JsmpfMPWntQZZJizFPJJxPVIAYFbDOv/OPlwF8K8g9isXzMz
 pZ3JJdH6Bon3pQ9dqNyFDQkKDYFga5YVpBQFCUbs5+1LPqUkqfGeGs/KDCNvIFQfRlBQ
 v98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773225427; x=1773830227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UXG4Mgxe1tz7YbglO0WtGRaw5MfIIMfNE+bwZ8iHnU=;
 b=Vzfe1z3Dmo2BhvygIAgA+33MrVoFzpfp65/8OiKkSQrz/Vxl+blD7QcikvwRKygLjF
 eo/a3LF6b4UUsa+i04kbVU802cc792ODoNL6TyT7UPOVDIewTuaHmVgHNZJXlK3tu6uq
 FrUhJleMBF6dGuGL8f7AVa4dtsguYOJfNVLiwkLBdmevF3YllSuFJBp+Wt+qa7xk4uyV
 khVbuX2vzEf+d6JhDhBqJzrkcZv1TSFkRxQjfMOl5m5rweI7AaOZtkYaX/mquecay/Yk
 MIRXOR4XGFR0Y9JUia7ArJQ8+OJItYXbIWcifL9RW1G38/8L5+jADZWHNf2fqHg9WSy5
 Zl6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNycbiiIGk/oZUw7wxTVqkDTuTG5euYSmkWS1Tdsod57vZi8AJYS+1YZL2Uh6q/yfcE8om43dpWDSb@nongnu.org
X-Gm-Message-State: AOJu0YxhujKjeZe5wUi/8PDsx32a0SOjEUDjV9dYNOdW2Zch+j2kfbgi
 NeoLRxqP8AtQ/AVQnLbNastK3q7Fp1I8LnGoITUQpJnuPJtKdcvXaOP1paNh2LnUqsUkHsUEiwI
 2bQwgqcR/45LzeLHNyOptzy+so/pbSV6qGo9cQO7kFw2p1Mr2jj45JztgzLZWKe4Ai9E7rs1ABQ
 RS5EZnRLlV2514VkbI4YIObiP+3sLJhhE=
X-Gm-Gg: ATEYQzz2qYEEoAAFgPEPoXG64TmvYwmJuBNcqR45AcfWCLPskac6PAkYAwTRu+z2lAs
 EW/3UW/oxxRxa9tPvN/9e6H0DvkU5Nn5lTlYsaUH3YiX1mHDijYMsT79qvXHKwZG5/1oCBiptDD
 SWxdbpbRL1HAWRISPWpG0+I/4/Fw4XZDLkwvWsZROY4NeUsN0btYnfnZ5Surg0Fu8QjW6PhEDCX
 CELgxS+ZXHbi6B+x2KusdsU6g+lVrYl4HarCP8ZWwZ02A+rhA69NAvd9PuRySPWFMnA
X-Received: by 2002:a05:600c:4583:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-4854b0a4911mr34785225e9.6.1773225426838; 
 Wed, 11 Mar 2026 03:37:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:485:4278:2558 with SMTP id
 5b1f17b1804b1-4854b0a4911mr34784625e9.6.1773225426403; Wed, 11 Mar 2026
 03:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-5-farosas@suse.de>
 <abCDJyknIzzX8dUy@x1.local> <87o6kvz8sp.fsf@suse.de>
In-Reply-To: <87o6kvz8sp.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Mar 2026 16:06:48 +0530
X-Gm-Features: AaiRm53wB06shgxByrZupR1Azhk6KpqxnLE_QXwRoYordlr4QD1utTxDEA64P0Q
Message-ID: <CAE8KmOypzYtQKoZJmn-0gpVW17+F8kJ22_zM_DVah8hLn7h7OA@mail.gmail.com>
Subject: Re: [PATCH 5/8] tests/qtest/migration: Force exit-on-error=false when
 appropriate
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 11 Mar 2026 at 02:45, Fabiano Rosas <farosas@suse.de> wrote:
> Yeah, what about I just remove MIG_TEST_FAIL_DEST_QUIT_ERR entirely?
> Aside from the ones mentioned in this series, there's only one other TLS
> test using it. There are two tests setting qtest_set_expected_status(to,
> EXIT_FAILURE); after migrate_cancel, but we can just wait for FAILED and
> then qtest_quit(to);

* True +1, sounds better.
---
  - Prasad


