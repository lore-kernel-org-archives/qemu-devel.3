Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F05FF60FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VxW-0006dq-Eo; Tue, 31 Mar 2026 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7VxU-0006di-RG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:04:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7VxS-0001Y2-Pt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774951465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eg9cow/Rwc/r301TJn8otz1CP8BR/I5P+UngPHw09ouFtoPp2SfW7JTeHXz6MjPIWVYWsu
 muREFyPd3S5O19qLE8a+G3H09CUrl/Vwu87mcygTZDJh5OkaD/ddBeS5VI/T/IkwNJScWb
 t/E9m9r8f3/mppYbbptqzyTz+3W+XDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-OUcRSXblMaaT9j9ckkCNwA-1; Tue, 31 Mar 2026 06:04:24 -0400
X-MC-Unique: OUcRSXblMaaT9j9ckkCNwA-1
X-Mimecast-MFC-AGG-ID: OUcRSXblMaaT9j9ckkCNwA_1774951463
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-487018c8244so35464075e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774951463; x=1775556263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EwC/GuHVuONHo7YdMAQERD27E6z5cS8yDiB5A/+zI+MJbqapVIkxOGMW130JhVtMQO
 I5gxpmMjtqkECe7nAhwMLfY45jcWGaGDIxkD9jziqTYOTfDzXqCPXr1RxTmYL7upJ/a8
 B/Jw5HuFRIENKNEqqxOjMBJns6b5p4ItBvEyX4dkNwAoFG0rO0UbtdIwaJxoUk7U15La
 RYl1gzjRW+eXPyOvIL1I8QUUOljnoCAWG0UW4Tcb99u/tsM4tYxxaMxP54Uu3ezFw01Q
 IGe1UJqlcUC+BfLJwtCt5s06DQVcV/CwlGvwq4CGM1n4hkCaSpjIBbGguBlBVdPnlgli
 /Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774951463; x=1775556263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cNKRTrDQdkfH4wFZcR9mjNjpr6xTaAPyqH/L+MCqGVehbhNdT8qPxgBPWACAx6I4UI
 qlCaPuRyoAHBmdfJP6/O11WKGiic+ZdDqc/Hxu/kXxcXGBxzzDlWYrrYOUwf/dOIZM/7
 f33X9ed08xXr1N602H59Q4+AvgCoSwsdfGisafibp2iuBZ+7U1nDxsvPeLkToqKASYJH
 YhEtkmv+ZbuEF1jJ4D5GVcU5O+TdMqUcJBokKISVyq+IuM5DoVhU4U1uIOHpnKjG6oVF
 QDzFWCP/sVoikS8/MJzBbBnThxDxpIVyuH6rT+NCb+O1FkOpIGo9ZPOm1Sk+MAEd6shJ
 syzA==
X-Gm-Message-State: AOJu0Yxwvsojyw/xNUIPDxmVvzlZqLhigAlk75zx56Z5zNHcU8GphUeH
 qwUsFJEFTfWDP5yXmFK1tpdkpduNAx6WZd8Ksir+t8unWWhECVikpKPdg0F+aW+TLVxLjUcVA5N
 NnvUx+RniR4aPmG81Ol6brSn4aVFshZaCpleC0ZaQ/GSACxJz13Jz/wiH
X-Gm-Gg: ATEYQzwT52UNjZk7YpF3gNSnP7OaMiiRw0KNQfcKkfGSw7TW/xi64xgDpAQjkmEnx8Y
 esiQjRtXNqMJDdqI0ZoUIikAESHat2h0qSKsb5mSRfdaPfHG6a2gx4HbO9kXvesi10pPvEmiI1C
 1vCy+Dq9zXuLax6CaiWyq5B1odSx1oMULvwhNNxTiB3uh5G9KNc1pggYuFk5ms0qRjnhzezWH8j
 wop/EdEJq6SAURLUtWWn1AMbAn+zrvhCSMXxWJCbi61Sli5Wm2RhO2bjzPC4GlbVYjrd/BvXb/T
 IZVHqkcZA4NAPr8SYIFVtWbqps4hFHEdou5LVdCzSZCoMo2zjhQQ05lEnu922dH905EQrxotSq5
 67xPrilJPhzM2BK7M+oAKFfHFAc8GtZmEn1OWaxVOXpfpns3qevaGL0kNGR7fQ49uw7LHhcDU4P
 wtvYH9I401MweXBE9W/U67ZLaZ
X-Received: by 2002:a05:600c:1d1e:b0:485:3f1c:d897 with SMTP id
 5b1f17b1804b1-48727f0b0femr266864105e9.9.1774951462942; 
 Tue, 31 Mar 2026 03:04:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:485:3f1c:d897 with SMTP id
 5b1f17b1804b1-48727f0b0femr266863675e9.9.1774951462489; 
 Tue, 31 Mar 2026 03:04:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a6ebsm30149475e9.6.2026.03.31.03.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 03:04:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH] memory: Optimize flatview_simplify() to eliminate
 redundant memmove calls
Date: Tue, 31 Mar 2026 12:04:21 +0200
Message-ID: <20260331100421.516042-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331060731.82641-1-guobin@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


