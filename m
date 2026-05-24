Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B063CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 20:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRF3u-000407-Mv; Sun, 24 May 2026 16:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRF3t-0003zS-Hw
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRF3r-0006dc-Hd
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779653073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNDYY4Hv/0XP2z+wqsEZhvuO8E0Aqm+4w8C6Q1/AefQ=;
 b=g4F8C/PI8UcDj3Y6jBdHNirfm5O52sTon4HhUN2AbstONh2NyeptIFSb557sNq+D1Vz/Fe
 QswxN4HcIxpjzmP6cqKKFPpkNvfzYWiiTlbipxA1bikpF4wuqjAwKicvJUHaFXaiCpKx1R
 tZxKUTvb5BGz5OqaokPvS+c7v/hUGdU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-S6GCrO43OZONa-8SVoECYQ-1; Sun, 24 May 2026 16:04:32 -0400
X-MC-Unique: S6GCrO43OZONa-8SVoECYQ-1
X-Mimecast-MFC-AGG-ID: S6GCrO43OZONa-8SVoECYQ_1779653071
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so7337280f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779653071; x=1780257871; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qNDYY4Hv/0XP2z+wqsEZhvuO8E0Aqm+4w8C6Q1/AefQ=;
 b=nlKvVK1B15dnNoMBykYERr423Z9CqsqmKAfnh1gdyHfgOOkciJYgmz4PjEjNNhznyf
 Se9JgnBFtzZ7z6m64/7JTErE6gSYoK3SrDUOp5qE+NnaT9oClfTf/bGf0Q89UxAFVqrx
 uUmHuoQWrUhSgOrOCXMB33x2un0a/q9pb8Ux/rxp9Vus+HR03MEYKWiYw7Xrh5vKJBgd
 UUgYvnaGbNv86ELpErn5sA9JVal6jY6zmLTjLnl7h9ZvIU1qP6oc9JoVrlFmQwP9d+rl
 G+IcajQGpGU7QFAvtaKiaEI4BpbW/CeUmMmnLGQqhPxJhtPZ33Ejz3mclcHy9tzNJOVG
 KbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779653071; x=1780257871;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNDYY4Hv/0XP2z+wqsEZhvuO8E0Aqm+4w8C6Q1/AefQ=;
 b=T8XXmVIBkDTBU8pFQuZbv/6zJZpMq0cXdbZhZfQ3MrTIBGW0X9IBPQi3sfBoqI6lHx
 LY/xqPMday+WTB73sLd4wT+5VhJlIdapNICchFDnNqH/ZfL6SdsTwgI43ljFDYOY/jG4
 R709YkAEjNi6qYIpEBYYb2OBjZvq8fw5PAroAN5nD10V735ZQkgDC1WT4deiHBvoanx4
 WF4DXUovpb0YgP/awq7xjtNqb2ykBsE05uGXX0u9TF6EZALAPeJwXkb467L2QEjBs90E
 aI+F3sK4sraBbEWFntfqQ+2lFuntd+a4R3IMy6mzU5BjnliTXoaiXqRF936N0QHCXLlk
 mrbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8S9SAWPtdQURcS6yuBQE83076Hvvr4QS8l0pBxlB1gAUnOz9mtXnDSA977BtEelK1MQ1nURy5eKOfX@nongnu.org
X-Gm-Message-State: AOJu0Yx2yYrj62XLMK855YwVE4Bw6L6njUISvkzjncRU7ZazlhrbLmXD
 r6xRaYVCeGNqyWs2a7A9JQcUvcylQr+rx985b41wCXz9tUurHurqauisyWjwEfmlNMGMkxe2etM
 L6M4kSwq7KI5FDqsZlkQh4CIANwGfjrE7Wz6UJlDWOkZEAttZzDgpg4Wm
X-Gm-Gg: Acq92OHiPGI3AT3Dp2n7ZGUlwFJSxBqOZiHxDzy+h/7WA8/jgAPeNiE1o2TP1STtvbx
 koSz7Xhy7li00aPZGwgfhgQnyMhB0QNr/D64oXiJVS/A3h6Y/4P1FVtXRcCb5G4KzYvDUr5E6ua
 944bc+TauJB1Ya3JPbDdKnmxsryqsnvnOKNl6rJiIsYG590vivQzZ1KLX3ri2VKnm7/sHO93IUI
 +I0XWNMbA6+hIzfMuBoKMFWP2VmeoIXJMVR6sBOtQun84e5BX/0sB9U2EBvw/ybzKlF4Sp1/h+M
 7DYqGIfRhzDYdLFtk5VtEeHTBxwY2rjrT27WYioHXqvxHtR+kCdlHXQpEEopdLRL8LfMv+JBjIw
 wz198NN2w8JTH2XovuNwq0KqZsW0yFxfaYRX72lXHUrM=
X-Received: by 2002:a05:6000:41d9:b0:43c:fb48:6856 with SMTP id
 ffacd0b85a97d-45eb36883a9mr20282826f8f.13.1779653070968; 
 Sun, 24 May 2026 13:04:30 -0700 (PDT)
X-Received: by 2002:a05:6000:41d9:b0:43c:fb48:6856 with SMTP id
 ffacd0b85a97d-45eb36883a9mr20282774f8f.13.1779653070446; 
 Sun, 24 May 2026 13:04:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e363sm22269523f8f.28.2026.05.24.13.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 13:04:27 -0700 (PDT)
Date: Sun, 24 May 2026 16:04:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260524160214-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
 <CANCZdfoEWBxjMXof7fPLnwL6=KfWys=fNg4tP8b+pFuhZZd-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfoEWBxjMXof7fPLnwL6=KfWys=fNg4tP8b+pFuhZZd-dg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sun, May 24, 2026 at 12:26:43PM -0600, Warner Losh wrote:
> So maybe a good middle ground might be to allow claude for things that
> are low risk:
> - Things sed or coccinelle  can do
> - Minor bug fixes with human written commit messages
> - Minor feature tweaks (say < 200 lines)

As far as I am concerned, if it's a reasonably split patchset of
multiple patches < 200 lines each, it the same.

-- 
MST


