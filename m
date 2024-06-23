Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48902C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLVG1-0005qN-OL; Sun, 23 Jun 2024 18:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sLVFy-0005q3-JS
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:00:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sLVFx-00061j-39
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:00:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fa4b332645so7045ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719180014; x=1719784814; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mvUs4SyHpfLj0EMVVmb+MYtLginfoCZrSoP2K88lRI0=;
 b=ggzbzUnUGgjG0kIIZUUZp0C4c4Nti5X1vstIYZ/4DKpHn8n8MN/JKG++WMJiEKPi14
 5EDRBh83bc2WZCTuRCIpkkw2Kyxoj7tbgbreR7cGYmU87/N0MHILcXqhRpCYQtyGJqnE
 taOISaArCxWa1YJF9P1Q9ciPa9uDxS5eSYCAtRyk9JgZNd3j+GAX0y05gGm6svBGaDP/
 7LyL+YKUFvfGy3MdAhW6Zm6YTtISegAhJtZoP5l8IpGxsB7Bh5bc2oF/Rt9wKbsOSVpi
 5jrEZlUZL1xhXancjBf5vVSZfsZrjWCcCRIP3MX3s2zuSVgG+OQPobXIFt63gYvL640q
 EY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719180014; x=1719784814;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvUs4SyHpfLj0EMVVmb+MYtLginfoCZrSoP2K88lRI0=;
 b=B3P2jmlYqa0EJ/WITWTSAwfRLJXihBQkTPH99GR7PeFt28+6hAC39H33ocGAYghy+D
 uq8JUpjDyQOtksJxOGCdB/SNajVTFO886+/6+wOWJtfrKbRX+OU8YJZMUsdnGA6bwgI2
 Hmu6rf7adxaOEMMv4ze5AJzXOPZLX1oadcX8dWaqKd9+ClgJcsDQr+n0L2XU3DVNcdZu
 MH+snCComnXnK0DJAgPnVa+xbmCwfXPh7NK+0cD1sTFued+T0x8Fs56U4V7b3zlyrNQw
 f/PzKmP+QpPlj3Esglph76ZxzD0Rk7oedQqoE1S5mfSrP+RLSX7j6XjeZJiNnPHMIBOs
 0M3A==
X-Gm-Message-State: AOJu0YwLQQKWHxM1ycVCB/JxycJrhIJOyiA/H3/JuiPhcENhoziPYMRS
 6c4Z2RKcoUIiD2qk9GG4SyRPkcm4fo4RkiKY1RvoONtkk2rdDiGQc0dFV0EyzEnmoAA7ZajCv8/
 yedxYZOFAtYYOMqa3Si885S0kBi/Yl6jKlTGDkNnIHnT+lGYWqPbp
X-Google-Smtp-Source: AGHT+IHTAWXiWDe1xvgB6MGpeTfDSBSHSsaph3GsVTWrnRiY56scJQtl84mSrXNjyEBbYsWyl0VFfOeHjJdvHGyvIkg=
X-Received: by 2002:a17:903:294c:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1fa09edcad2mr3132145ad.3.1719180014240; Sun, 23 Jun 2024
 15:00:14 -0700 (PDT)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Sun, 23 Jun 2024 15:00:03 -0700
Message-ID: <CAOGAQerHV4xs=QECi7JCrv0sFZmjNO=-mVecJYzd6ErxvvAJpQ@mail.gmail.com>
Subject: Deleting the timer data without racing with its callback
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Bo Hu <bohu@google.com>, Yahan Zhou <yahan@google.com>,
 JP Cottin <jpcottin@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rkir@google.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi QEMU,

we got a report that our code (a wrapper around the QEMU timer API)
has a race condition. I tried to fix it, but unfortunately can't
figure out how to do this properly. Please see the
`timerlist_run_timers` code below:

bool timerlist_run_timers(QEMUTimerList *timer_list)
{
    ...

    qemu_mutex_lock(&timer_list->active_timers_lock);
    while (...) {
        ...

        /* remove timer from the list before calling the callback */
568:    timer_list->active_timers = ts->next;
        ts->next = NULL;
        ts->expire_time = -1;
        cb = ts->cb;
572:    opaque = ts->opaque;

        /* run the callback (the timer list can be modified) */
575:    qemu_mutex_unlock(&timer_list->active_timers_lock);
576:    cb(opaque);
577:    qemu_mutex_lock(&timer_list->active_timers_lock);

        ....
    }
    qemu_mutex_unlock(&timer_list->active_timers_lock);

    ...
}

Suppose another thread wants to destroy the timer (including the data
pointed by `opaque`) right after line 575 here. How do we prevent
racing with `cb` here? I checked `timer_del` and it seems non-blocking
(it does not wait until `cb` finishes).

Thank you.

Regards,
Roman.

