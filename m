Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A361CCA5FBA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFb0-0007vV-Sc; Tue, 20 Jan 2026 12:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFax-0007lp-RU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFaw-0004Ey-BQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kXakt/+Ldv99CnbkW6EqLpjKJ+Pqsv8XBG8EjouJCI=;
 b=A+m5Pt61pb+dfUhCxQZlAOdoX4cpSkGorDzyXa517TxcRR0XEYYl/OMWHR/b1nef2VM3DD
 LvHYVkNQs6IIP55OvHnwaPVNMQx8nqF1xHaOOzEAfaOghuAeABAvQC063BrEttd9ZdH1jR
 X6KULCj3FjaHolm8qsjIM0I5/jfLW+o=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Q-MkwUIsP2G1efTUXh3gdA-1; Tue, 20 Jan 2026 12:32:44 -0500
X-MC-Unique: Q-MkwUIsP2G1efTUXh3gdA-1
X-Mimecast-MFC-AGG-ID: Q-MkwUIsP2G1efTUXh3gdA_1768930363
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b6ba50fc34so3319783eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930363; x=1769535163; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0kXakt/+Ldv99CnbkW6EqLpjKJ+Pqsv8XBG8EjouJCI=;
 b=bJDp0HVDXqUcmB02ILXP0X+mqTg5KFcSmixiVTNGIt5bWHFpTZqYO7weVrPWkxYDf3
 OKKSOSsL6lP+6LM2WZ8j+1EH5SqAKfTa4EZSYKjM2pyPcPrs6wx4V9Ken+USOo7XaA9r
 XrUrlpsDA3mq33Z+7I054BF+8A1ZdX2Trl/NjIrcjBkLOUgWzxkuMmru2uHaw8OIbM/F
 in/+qqUtw1RNHG00jTbQ/A333MiY7P0lRS/U2D7vi0BLrUxGRSh7L1qvElfeSUbMp+ac
 Hyyykdk3/vPndTtqsVL44rg65p13HAbx5n3xuB6gNYptT4wkDMkYQ400PSnlPYrNg2DO
 rraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930363; x=1769535163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kXakt/+Ldv99CnbkW6EqLpjKJ+Pqsv8XBG8EjouJCI=;
 b=kEsH9RDphgeVRuZqtpE+g3S0HBiWzKma/mITSCOsfwQA//dALcRSDSL/PWCe108xZ5
 NIkA4uAIj0/ONuwICICdj35KUM2AgYioFABsXnwhU07MQuLNdz44lxzN5Fxp0C92uI0H
 tc8Z5gwE2qXv0hT0cU/euE3ymgsSyQQ0R+O3Ngv0/UV2xvYpiVAwJZHQZTWl7PEMOhNG
 Xt0oS+JImFeZ8vl/WYanhA4VPxusTfwFR+t/eAeyd58WVl4THqm/CWr7/DueKKnO7OyM
 QgwnzK9aZgFlwF+JoZontWn3CwpYLUGqhAKVhS4CXtOWsBpspk8fFSJxL52lmen+eNmT
 tGlA==
X-Gm-Message-State: AOJu0YyGgsq9a5n5xefq1f/8UCzl6U9MT5G4sKmn9xsUFZMMiZtQUUID
 l17h96Rr+55PeZ34wm3b76uF0cGVTbR4Ab6zq2VuOwyWDA2jG59HqsNMZxfEsw82FmGe7cKU9hC
 kXS1W3uqDAXKsw1QMj1cYsy7OP0PqXO3sP9CT7lAJTaCIfRO9dcprVZWP
X-Gm-Gg: AZuq6aJFaRZ+rA5IJHb7a8HPLctMC6iwzyWAKBURALZjvlk+IYms0prAITi1lPf4GVk
 fiaV3bZWXi9/xu2tw3/jIJaxMfIbGOM0W/7j1hvb004rA/eqOGc9c81eKLiPCKFJLRVL7kh+xB+
 y+hPuVvllbVQnVOE/FSETC3eEf1d/sM180/xuLm1srRV5bF0GZQ2ONnHwY7/WSSKskJziFsmWzU
 boqKbPIhCyANXIWoIOg4JFNk0XmV+efJW365olw52DHvdowuPGub2WMWyn8ko3TI9QLzy+XZ+4h
 xm3luEj9BoztAQ6B0wJezxcde5oF9rkN9vtvnS/ixeCb049oc0fbeXO9wLDd4HHXMkRz017GfN3
 oblY=
X-Received: by 2002:a05:7300:3206:b0:2ae:533d:19ee with SMTP id
 5a478bee46e88-2b6fd7b5e37mr2170997eec.21.1768930361355; 
 Tue, 20 Jan 2026 09:32:41 -0800 (PST)
X-Received: by 2002:a05:7300:3206:b0:2ae:533d:19ee with SMTP id
 5a478bee46e88-2b6fd7b5e37mr2170884eec.21.1768930359352; 
 Tue, 20 Jan 2026 09:32:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6fba43c3dsm3583255eec.0.2026.01.20.09.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:32:39 -0800 (PST)
Date: Tue, 20 Jan 2026 12:32:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Add myself as maintainer for COLO
 migration framework
Message-ID: <aW-8L6f-CMu8iMHx@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-1-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-1-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Jan 17, 2026 at 03:09:08PM +0100, Lukas Straub wrote:
> I am ready to maintain it.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


