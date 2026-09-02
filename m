Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9A7C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hXw-0007sl-GE; Wed, 02 Sep 2026 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hXv-0007sb-Ci
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x1hXt-0007xb-4A
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788342376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhXWfGC81i73m+kEYm1JmOphmC6c6mk3GDheRY+GXyI=;
 b=iMjoMeVt8fM8pL7MGpK47JWgiCck4q31qv9DrcJ+9epTMkfM/uyy99hiGUHIQ+M63ASJ2j
 gBR1G3wCDiMWjvH7sp21W7FjX/2WscQyYYYy/yz7AqaLsydXp8B9gP4TjL1Mbjtf8takd0
 c/ufsvHJd1t4SCLaSCv4QXhXJmBU7lI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-3JvOFJIcN7a6Eee8FbBghw-1; Wed, 02 Sept 2026 05:46:14 -0400
X-MC-Unique: 3JvOFJIcN7a6Eee8FbBghw-1
X-Mimecast-MFC-AGG-ID: 3JvOFJIcN7a6Eee8FbBghw_1788342373
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccb223bceso5229185e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788342373; x=1788947173; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XhXWfGC81i73m+kEYm1JmOphmC6c6mk3GDheRY+GXyI=;
 b=Pe68wZriy5S1ML4tRZ3TK0Mb37irbwFMxxg7vPbs1l0qiYA8SreZs197IVGH+vGcG6
 BPAvqclea2RmbAVsJkeYE1QzlDnlx+N6VDj9OeCSXT6t/Ho+26p9y+e28b6q65OTrSp0
 Na5UQAJRO4WuIK2DCh/Okxb/FYZA6RnU7qJncJ3dkXHQl6EBr2HxilvO/vzxMysRN/AX
 +kcPNKVDSj+AvNoZu8bNsmpv8NZwWaFqI1/lVHSImUW/eyS+dwdZAPpHeDb2X4NsBcgc
 9SPLKNGISweJS0c5hzQz7YemJFJNZIQ+ZajYsuEFyNnStj20Xy/gCJM2tI6CIdaav+MF
 DbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788342373; x=1788947173;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XhXWfGC81i73m+kEYm1JmOphmC6c6mk3GDheRY+GXyI=;
 b=SxDeLB0aB+3oCaBhzCksb0bItxf5yERYzEcAcyQtNVgVyKBIDCoBIH0GZlknzSi+QG
 YhYG4ZuY9slpHGI1pKbPPwx10NOFHMc6qByNxk2EXANApKEAsHzg1DYijntw6noTTMNv
 JsoGV4PV+WlcQ3UWL1SwfTGr4d+Yl2JBKnEQS9GHvH0wrurZJBpc80Eg5GaHGRDBqlBW
 8inoEHGQUhrp9qqaNfOgDN71IJ0zE5LFQDzZbhLNR//TXkN62QcmDbusJtjCrey5dOce
 LQuJ1h3YeRc8RfxbvEUwWT1HXYAfRPofcANVCeelzDjovjYzlyhJN9Mgvrq3VU9VXP42
 9/vA==
X-Gm-Message-State: AFuF++kP2Q/JC8s4j4IpM56RqR5wIukSczivWTLRMGvrJI5USekaz9PI
 wbY9iZOUyHRDObA76oQi8L9XwBHgQtD5qhoziSS9o66zJpFoD8VLXrKb4SGTFO4b253fUiwnzCp
 ulVTZjrVNOowWXtBHPsfdW1KaIH48VBABSVqSf+oDI/QpYK1cgpvXM6MN
X-Gm-Gg: AR+sD10TIVwH+HdnG935eTKZN0OM/I9kzzA+jJRV8L1CBkX8GshVuNSM1zvf34lAEqZ
 xgZDRePmYwnMzi7GJGrJeJCtJtKgfGf/uB0tG/UiJ+grkjQ7X4pEEBAqQpH6x6UEzcQPda8pof2
 QTXTKimyStNQ+BSIrQQGWDAy9hG9SCpJA89snCxqNL2SwI6lKN95sMNv0RyUwrspyTZH/PYTkmu
 /zu89yLWxyZdvF72BobZ4fFQFuUU34zvg/UrjsBcpH+mE7msVNT8VfVsk8p9Twr1SJRTEl+Jcmx
 ipGuQ40qgkN3F4/DazmFmM+1n2C7DD4yIiUQFY7ufj72WOsPfQv90VOBpfL9n5HCAAk=
X-Received: by 2002:a05:600c:3f0b:b0:49c:ced9:ab7f with SMTP id
 5b1f17b1804b1-49ce7c316aemr30044965e9.8.1788342373375; 
 Wed, 02 Sep 2026 02:46:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0b:b0:49c:ced9:ab7f with SMTP id
 5b1f17b1804b1-49ce7c316aemr30044085e9.8.1788342372822; 
 Wed, 02 Sep 2026 02:46:12 -0700 (PDT)
Received: from redhat.com ([187.15.128.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce4a804sm158382965e9.15.2026.09.02.02.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 02:46:12 -0700 (PDT)
Date: Wed, 2 Sep 2026 05:46:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Message-ID: <20260902054543-mutt-send-email-mst@kernel.org>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901161422.314581-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
> Claude Code and Gemini CLI do not read AGENTS.md.  Reluctantly advertise
> them to facilitate following the rules.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  CLAUDE.md | 1 +
>  GEMINI.md | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 CLAUDE.md
>  create mode 100644 GEMINI.md
> 
> diff --git a/CLAUDE.md b/CLAUDE.md
> new file mode 100644
> index 00000000000..43c994c2d36
> --- /dev/null
> +++ b/CLAUDE.md
> @@ -0,0 +1 @@
> +@AGENTS.md
> diff --git a/GEMINI.md b/GEMINI.md
> new file mode 100644
> index 00000000000..43c994c2d36
> --- /dev/null
> +++ b/GEMINI.md
> @@ -0,0 +1 @@
> +@AGENTS.md

gemini seems to support agents.md - r u at the latest version?

> -- 
> 2.55.0


