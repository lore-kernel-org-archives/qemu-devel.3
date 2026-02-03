Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB7DE8784D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJnb-0001Hw-Cg; Tue, 03 Feb 2026 12:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnJn8-00018F-PA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vnJn1-0008S3-Dc
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770138129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Et9EguKbw4NAk34vNwfy6uXsGwsluwnBxYsXz8Wt3Oc=;
 b=Jop55C9j07rcrRMC+K6raTOgvFkhAp/6Mcy9LdiJXT5Xp3+CfIlKdZvmzQfvrgQ2iAovD4
 ym9TX/J5++s2kHj7jDwQMXGbxDa5ilmaiVf/Ge//n3eCSzOx5pJgR5/dlpzVnT8YoaozQ4
 lHHSNe/zcHJcizylefYL/Lb4ra/0U54=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-0f9tQbBANEyaZLtrklmLDQ-1; Tue, 03 Feb 2026 12:02:07 -0500
X-MC-Unique: 0f9tQbBANEyaZLtrklmLDQ-1
X-Mimecast-MFC-AGG-ID: 0f9tQbBANEyaZLtrklmLDQ_1770138127
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c5296c7e57so1337030685a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 09:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770138127; x=1770742927; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Et9EguKbw4NAk34vNwfy6uXsGwsluwnBxYsXz8Wt3Oc=;
 b=TXpwGCfkagzHnn6BrzkxDfExRRTiq3q1rAKqs4dixZlEC75JZMxmr/MAted0hozWea
 ZnKUWL9zYqEjjK112SGPkJHaZqk8ThV74yt8u1nimPfhpsSWYsw01rkf/CZRw+yQLNW8
 2QpdZ2BV5l7l11t+7ER3lerx++Q9QBb9R8mwj++RXpPV2kX3KP4363LIKT/U4lc7SLnU
 rzXdcWJ8T5H9AdMZZnPCLM4EoDQPUD3vEmeuCNMsBslwFJ8tuppQGpJnQ0GLCPjNACxH
 qlJtmhRdURpHpAfJ63N82dN0ClyZNYKQLxXJGT//nvJ0GFc0o2whci4iL4JtrRIAV7Fw
 U6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770138127; x=1770742927;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Et9EguKbw4NAk34vNwfy6uXsGwsluwnBxYsXz8Wt3Oc=;
 b=aQCCLEdfkrCfX4RsMolsC5F6vLTbjJ09pbv6KryOT4m5SrCgwGxFF7+oixRY5z4L8A
 yRKcvO3ywJiJVqHvioTReS7kSL+QacKTAx13t+aabUoWV92ZiTWf4SLR8e3JZZsAMe63
 FjlKzpnKe3j/9m8aZsNgKGvEoC4nWvdxld5z9wPhYE2so9GvASNzaZj1qqV9DvrMp65W
 b5iwmK8VlALS0b+Xn80Bse4I1N1s2c48r9V0qtIJ8vgGnLi1N50DUPJEEhD+de2v0ANq
 uPt3WA54HdzaRQuzLqc6QHeZXc9M2w2iNTvUJuom1CLMw7Yk3fV9p6crA/2ymPcd7klv
 RjiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGYrF3zQY98it6SnVuKjsUpbKTA5W62KsZcFMswBMk7MMXjH+4v4SOoplcgoAL6dMBgedGjhs5Mytt@nongnu.org
X-Gm-Message-State: AOJu0Yx32VGdVG6uGItClQXKIcvVecvTENBwpPb2pQ7yGpRRTY5hLtEy
 c1oc0d+8InMSTGROAh4gXjndcqR0HGPj0SwOB8OYtucm3hNsbpRGKkyvP+dhy2rwnpU3fbbs+pj
 RZtJeDxCWPFtAoVRmBj5F9Skb7MOdWHb86G8RLiUT+9wvFZEEVOLHb1Eo
X-Gm-Gg: AZuq6aIedG2y8SPU5QhU4P+0h59PMSrx8xH1EFa1mI/8vVupPAvqVUNenc639FzBs4F
 hr3I6ZvedLF2k557dbGUsDx3pIBoiUB6iZKtcPVV4eoeTfo4udhuG8++qmZiH39dScwdoQa2aX1
 ldwUWfAwHi5Kda/xY8PkXwitAGQfAWPI7NVoEVZXEcdNoiao4nwzTKN9oAIjlXfhTndmuOZLc+W
 X7ycElzI6KpU00ulH18oE1223fnSdJboHzcqQ/bHb2On1AtH6n6Cx9FDbxWJEJaS1obnw67yARH
 iEfG9csCNc+DGLf7rAwUDX2Q8bCC6XNK4nwpFq286jacGi6fL0o5ZlvM9e96T5+dJuygEkBR70Q
 pCRk=
X-Received: by 2002:a05:620a:6cc3:b0:8b2:e70c:427a with SMTP id
 af79cd13be357-8ca2f9b1220mr27547985a.44.1770138127040; 
 Tue, 03 Feb 2026 09:02:07 -0800 (PST)
X-Received: by 2002:a05:620a:6cc3:b0:8b2:e70c:427a with SMTP id
 af79cd13be357-8ca2f9b1220mr27542585a.44.1770138126481; 
 Tue, 03 Feb 2026 09:02:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fd2cbe5sm7792685a.28.2026.02.03.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 09:02:06 -0800 (PST)
Date: Tue, 3 Feb 2026 12:02:04 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
Message-ID: <aYIqDAdld4a41VDy@x1.local>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 03, 2026 at 05:48:11PM +0100, Cédric Le Goater wrote:
> Peter, Fabiano,
> 
> Do you think it would be interesting to send VFIO migration events
> by default ?

No objection here.

IIUC it's a matter of why it got introduced with default off in the middle
of 2024?  If it's about compatibility of any old mgmt which may be
surprised by these events, then we want to know if they're ready, and then
if we need a compat field for it in older machine types (or enable it even
with old machines).

Thanks,

-- 
Peter Xu


