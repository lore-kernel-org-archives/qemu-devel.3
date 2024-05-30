Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969A4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCn1J-0001vU-9u; Thu, 30 May 2024 17:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn1F-0001us-2a
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCn1C-0003js-KB
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717103341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgyHYQGzeJHJbhIrlSS4b7ssK8Crf1hY2jI7djG7Vgc=;
 b=F7zbsjrpvcn6OiK6Y3lfOTPQWJMg1O3VpT4w89Z6YXWcT2jEtGuwyJHb4gAYgskUh8ZS/1
 UXhRy5rkyJDYd8unJ9XcR2bnm0COibveG8s8KjzI6yXHBKtlh3G4mA+F7etsGqay0b96zY
 ufmnEJqZRsIIvephGJaYv+slcefewRE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-yC6p_NfPPDSmU52xtNRb2Q-1; Thu, 30 May 2024 17:08:59 -0400
X-MC-Unique: yC6p_NfPPDSmU52xtNRb2Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d1bdefedb9so187677b6e.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103339; x=1717708139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgyHYQGzeJHJbhIrlSS4b7ssK8Crf1hY2jI7djG7Vgc=;
 b=mCEaIke7oJFZNqaTVaiJzmZ/MabQuGDFnLGB3RpvOFOgGQLZkSfWAW7I8eAn5qa/jm
 AhFC2WRyF1VaPrsmZANwp4stod5YWKDknU1LqV6x91amA205ybRTitjXx27uWr0/NrKm
 v+gsmavvDM+SW27PceJDRjz4RGnnhjyrGz1io8wWhg1TqFBzQO60yO/y0tO1HT64CsM+
 TesC4G5C9SgufBySslpiBol3og6scLFk6cRk1z4Ok+Bz9JKSlLKi43ypbLKUfZv47F+S
 6vZnEyy4jHaRYqMCe2C1r+FH3b/2ZrAKSeHfdk2+RVTGKaIpG7AuLstVna4dnUlVH8S8
 aBiw==
X-Gm-Message-State: AOJu0Ywko8qnd/nYkxrNVfs3ZWgnsVTqvGHh00DHx3rc2JZCVvyOup6/
 VjhJvRUISxzEBtgi3Cgfd/5Y/PeSRAZTEEHGtykSkaJpSb29X+nTxiYf/50bhwS3/ogxvBbR+mJ
 Mj7FPKBTj5xBrl11Sut1L8sXFMWjpktZhsG+ePr8qr4SsqPPOD2JW
X-Received: by 2002:a05:6808:1788:b0:3c8:49ef:cdf0 with SMTP id
 5614622812f47-3d1dcca28ebmr3851988b6e.2.1717103338662; 
 Thu, 30 May 2024 14:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKIrWCP+xXhd4/U2Hr4Dk/u90IncoMyuZ7qttVuLNAni2Mp6rCaNvQmYUFtqxcqR5VXYkcA==
X-Received: by 2002:a05:6808:1788:b0:3c8:49ef:cdf0 with SMTP id
 5614622812f47-3d1dcca28ebmr3851948b6e.2.1717103337904; 
 Thu, 30 May 2024 14:08:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b417ccesm1670576d6.122.2024.05.30.14.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:08:57 -0700 (PDT)
Date: Thu, 30 May 2024 17:08:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/18] monitor: Report errors from
 monitor_fdset_dup_fd_add
Message-ID: <Zljq57-GqeiZN3i8@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:38PM -0300, Fabiano Rosas wrote:
> I'm keeping the EACCES because callers expect to be able to look at
> errno.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


