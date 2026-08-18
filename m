Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA63EC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKo6-0000fC-Nc; Tue, 18 Aug 2026 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwKo4-0000ek-AG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wwKo0-0002TM-3q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787063322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c+1vCjipo3T13zN9O7bjGRW0oy+eenTbyCMIKp+jwBc=;
 b=GQheLVXQawCIwY5ofWc0Nw0J8dH6tHiMlGkwlV2hroXQpqC8EX0/hVpNqny/YFrWEai8b0
 yOeIPTpYW2dxcYd2cNctylb+9zjl0IQj3k035gX51Vf745V1+LwI0RwhXKdVmQZXRAquM+
 hc/Az3UgH8awZv7cj7jGCNiN1KH6sho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pcL82dTOMXCzG_jbw563qg-1; Tue, 18 Aug 2026 10:28:40 -0400
X-MC-Unique: pcL82dTOMXCzG_jbw563qg-1
X-Mimecast-MFC-AGG-ID: pcL82dTOMXCzG_jbw563qg_1787063319
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8f8fde2dso2870216f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787063319; x=1787668119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c+1vCjipo3T13zN9O7bjGRW0oy+eenTbyCMIKp+jwBc=;
 b=oc9eVmnR5NJc9hbqoEt8ne+aOe1cE38yd1egXp7W658Fa1f8o+F3WYXFH38oDZu5yT
 NxqtPVCd8x2FFOqG0as/UiY9UBHnD0NsI9e6bsM32c4mC1tcSz2qUkbVvQlWMhbAAtOU
 d3U7ye2JGh+bBVyO3oOoSLttacRc594QRZTJ0+aYMSnTbw4DUmgNQ8PRvhmW5dDzATAn
 9/rk/tMt7UYJUXONltUTGcfSHT5Rn/SFd4uV6NZNYu/ffbrTMr1SdsCDo/3BmKfde16w
 TUfBvwSelLjlHMflw09Kx2TlWc5eP3j4lWIB1G8phR3fGpL1fAEW2NSkwc+wBMNEjsio
 wk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787063319; x=1787668119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c+1vCjipo3T13zN9O7bjGRW0oy+eenTbyCMIKp+jwBc=;
 b=KAEmUpEMlnESSq6m7Vd6r1nsYz+jk6xZNURX4vErvMjbLPgSPkgXS0WOCVb5+XpXt6
 7E0hfYm5TsaZMfRWK+cy6tiZfjYFcs1OoiEj5vtrDlXz4HVxKae/0I86rpxvx6CofRbv
 HFxkUk/Go0uujr3Yxig3FA+JoCsIHR6MIluv8iYVXztqK7RytLrQh4XJGu8r57JjynFX
 jm10FSUBJWinAve9+KivYanh7z961Zb2OrSBNa5F4CySsq3K52wwJi7Nxeo9+WuDO/dK
 d/X6uN9qvkhNwPWFGUIOiZf3ADevBSIzrBbMXnrwQWA/2h/utW3+L46DpNi2CMoauVHJ
 7QsQ==
X-Gm-Message-State: AOJu0YzlHIUwhDY/y55MWX2CSPJYDMLlCPWWlH0VhzqpJE3Vp+wOPKmo
 0hbhvQfTR/YA0QYqx27dnNlEl1ZH7t8UriKCs8eevh9D8H6QwWhk19IofCpJ9TEnHA16MIVyMy/
 aOlAAArPh81XQQ7aJ0GaIaC20osOB8QqfiOQDRm04ZGWnt3Lvzrav1GAeg4qEakRwhNvlsbk3R4
 Sc2woI89e3VeNxlHr2gvp2UuzxN/B7Dw7tMoDOnW1S
X-Gm-Gg: AR+sD13r1s1c3W6ChdnqscVvtYniwTsVKRVLdGJ+/sabnsB9PFf0EyunFVVz7N9YWU3
 38mXGS4Uc6qkg2rGIiDy6w6cFAUdTmcYCTA2yXuM4LeHjVpVKpP4NSu/z6vFHAG0loQsrFMmYAJ
 Wt0Ie4ODjTMA+s7lHSWDypifb41X5Goz1/hkDg667TYynRcua8aCakVYW/RVAjJbaPATViWY724
 VHXU/susI4hv3ntvlPZfij1/6YZVFlusq1JEhdY3BQFQCd7iiBpwVgJuI3jxc3lQy5h2Gt8hWvP
 k9D5H3PWdeqD5fs2h6fJi4yZtuxJkhh8ZaoDAgVdwrVuhZd6261EUVztB7aka5mrjMYr86Mdvmw
 JPctbQaVvUA7gy9Di715uk01IvKriaqLU6PcWPBfR4SK13TN6j1GD1sh52eg2X5v9
X-Received: by 2002:a05:600c:4614:b0:499:858f:2653 with SMTP id
 5b1f17b1804b1-49987929193mr358169485e9.2.1787063319318; 
 Tue, 18 Aug 2026 07:28:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4614:b0:499:858f:2653 with SMTP id
 5b1f17b1804b1-49987929193mr358168755e9.2.1787063318814; 
 Tue, 18 Aug 2026 07:28:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b783c6sm13033056f8f.31.2026.08.18.07.28.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:28:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] serial: clear transmit retry callback on unrealize
Date: Tue, 18 Aug 2026 16:28:36 +0200
Message-ID: <20260818142836.1664990-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GSource is removed when resetting but remains active (and can
cause use-after-free) on hot-unplug.  Remove it before the character
device is disconnected.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4125
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0729cd2ce9d..4339562ab00 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -936,6 +936,7 @@ static void serial_unrealize(DeviceState *dev)
 {
     SerialState *s = SERIAL(dev);
 
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
     qemu_chr_fe_deinit(&s->chr, false);
 
     timer_free(s->modem_status_poll);
-- 
2.55.0


