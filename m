Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F4BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mN-0001BW-6H; Mon, 03 Nov 2025 16:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mL-0001BO-CK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mA-0005Xy-Lg
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hlU1e2q6IHd4qNTNcT2O05B7HEt3dBs27yp1q95x+vY=;
 b=YjPoSJF9sZlF9mP97vviKSOhylTeXXhQT2PBovmV9BSBXkTVRWm5rCulaz8tIJ1YYhRT2F
 vramsKW2I3/fpBPahrZHrWdHzq6Pm12F/uNqs3yr/a3BJuNkL/8NLLYcZ1E+K+WeG0gtg2
 x3uAtzKJB1JKQmmq5Hu4bdDXgaeIu/Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-RED-cso6Mq2q-BQckeDtfA-1; Mon, 03 Nov 2025 16:07:39 -0500
X-MC-Unique: RED-cso6Mq2q-BQckeDtfA-1
X-Mimecast-MFC-AGG-ID: RED-cso6Mq2q-BQckeDtfA_1762204059
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8804b991a54so83166156d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204058; x=1762808858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hlU1e2q6IHd4qNTNcT2O05B7HEt3dBs27yp1q95x+vY=;
 b=reUlcaAyjhnLUBx3Nd/V5/JoSusHzzl7Wn9EpqLf5LYymslPmtjPP8uMeLDwzwmXFS
 xpPYlHmcHNCgp74zf9ilITIq0yirDtT+Nflg8Rr0rInAIIJrdn32dnRw2vMYt6hwAj76
 /01ACrOvgCg+r2swxVGpx9RBa7JYuc3O0eL4mj4rgmPbD6PtTE/H1De+mzTDYZYyNTn6
 t0V4SC8cGLvZKO1bGJPDUTs3YN0MQoMbLh9zHKIAVpezlggOlbERHy6KROeBe0+pBS4t
 wNfcKScVRXQONi8ulvXUW1fpqihCXpTL14vu9n9/zv3MGKN5eyvlS0rpEXs4/l7ct580
 3b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204058; x=1762808858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlU1e2q6IHd4qNTNcT2O05B7HEt3dBs27yp1q95x+vY=;
 b=VCW0Xu000VPLd1bpRKjBdCqsliXZdT2/oHsH07W3vrHUCERDq9N2mY5G4JRPXBFY+f
 MrB+F0rLYDhQqJh3kXP1kWKdJ9/8kFXhweQ9lisG2O5J0tjEZMkoznGKCHTN/rmbQTUX
 KBy/0q+2Z9WR9PyyCTZa2tvxOqG/DVqBDBYEHjDh7fQ/pXXW39HQRFz+SauzXyC80Ba3
 /vwz55IhO/tD+ygWp/7av9mQLjfQz1kWsmKaFO4axmPaDT0gmuzwm5fgEvOE3iSNfgv/
 KtdO/iqrY6asQ2YO6bhMOenkWugZgeYUp32+SBSOHdGqpGubCUbs/j1caugdAmbkdJg7
 itHA==
X-Gm-Message-State: AOJu0Yw/1YeIdZjv2lMj+C1T5q6tFPNBRBamAZsYbTyNF8UQWSvspQ3y
 QH+bomXerOwnrfFl/ak5HhB6pI32YilOzOeIkZlADn9PIrKq8zZpPcZ4ebBCsVp1B6A9AYm/+zi
 7v9lD2hAb2Q1bWsq4Eq5FXQsZ+PZDaCnGo8zJ5xlarRBpGYQHatCmIceJ
X-Gm-Gg: ASbGnctkcOyy+grwxrzyOyU6DU/lu5m3P7AnQgUQlKFP9UMPRW88Tv0pR1y1EyuYyLc
 nXJkYfW169S4UJ7il+02Y3dntEZJOf9C+VpLTv5wZCkFHEDZTyS7qPZAAdVV3AwAcWJf13aIIva
 VA+o1OamN65aj6sc2m5/z9/3gOmly9DFUHe0dzPc+/wC0jEC8j8TJGYK0oYJXXorXOpnhpJmOp/
 D64MvDq6WJOnGmbvix6ZvH1KUuvfLK0efmdVdEskFDD4LsKoorDBQP6vRikGmX8wqQjaK9lMC8W
 BulCrMHxTwOIZdE69vVWLkCFASXhMrIo/bGaA17e/S9o1s9CT0JrVej9yF3OmJ4uDUo=
X-Received: by 2002:a05:6214:19eb:b0:878:c2cb:7a68 with SMTP id
 6a1803df08f44-8802f453044mr179715566d6.43.1762204058447; 
 Mon, 03 Nov 2025 13:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG43/nL1jHIey8rI88q2L8eU6O3PLQdRXqezshKikxZrsNfPtWxrSR/PnvSRCXyVc3ewvNI7w==
X-Received: by 2002:a05:6214:19eb:b0:878:c2cb:7a68 with SMTP id
 6a1803df08f44-8802f453044mr179714986d6.43.1762204057841; 
 Mon, 03 Nov 2025 13:07:37 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88060ea9f47sm8990176d6.56.2025.11.03.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:37 -0800 (PST)
Date: Mon, 3 Nov 2025 16:07:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v4 0/8] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aQkZl90HJA5hpZrq@x1.local>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103183301.3840862-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 07:32:49PM +0100, Juraj Marcin wrote:
> This series introduces a new POSTCOPY_DEVICE state that is active (both,
> on source and destination side), while the destination loads the device
> state. Before this series, if the destination machine failed during the
> device load, the source side would stay stuck POSTCOPY_ACTIVE with no
> way of recovery. With this series, if the migration fails while in
> POSTCOPY_DEVICE state, the source side can safely resume, as destination
> has not started yet.
> 
> RFC: https://lore.kernel.org/all/20250807114922.1013286-1-jmarcin@redhat.com/
> 
> V1: https://lore.kernel.org/all/20250915115918.3520735-1-jmarcin@redhat.com/
> 
> V2: https://lore.kernel.org/all/20251027154115.4138677-1-jmarcin@redhat.com/
> 
> V3: https://lore.kernel.org/all/20251030214915.1411860-1-jmarcin@redhat.com/
> 
> V4 changes:
> 
> - fixes for failing qemu-iotest 194
>     - flush channel after sending CMD_PACKAGED data (new patch 1)
>     - POSTCOPY_DEVICE state is now used only if return-path is open

Queued, thanks Juraj.

-- 
Peter Xu


