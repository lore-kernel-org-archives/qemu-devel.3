Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84744C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 20:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tah4P-0005d5-FM; Wed, 22 Jan 2025 15:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tah4M-0005cv-W1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tah4L-00088Z-Ep
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737576674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzZaVxoRmHBIjqRSACqaBOYucdwJ62YXPmrMxSkx3sk=;
 b=Uq1n96Sn+H5IbB1KiYQeY9Wewg74Jer8YdXeWOkwMAZQCsbFVKhw0KX67JRznQTH0Uk+vO
 O9yCltSbUnnHSBxT71mhyfF8GaH3pXm0sPQzyeaNBeywzxERJupHavcrDEeC7iptl9RjTG
 VcPVtNrd5UErP+FIPZF69t2UsIbeWvM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-0I_1sAluM3GJjaLQ6Tixkw-1; Wed, 22 Jan 2025 15:11:13 -0500
X-MC-Unique: 0I_1sAluM3GJjaLQ6Tixkw-1
X-Mimecast-MFC-AGG-ID: 0I_1sAluM3GJjaLQ6Tixkw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso2114371cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 12:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737576673; x=1738181473;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzZaVxoRmHBIjqRSACqaBOYucdwJ62YXPmrMxSkx3sk=;
 b=eX9TfUAcTbeNtwHVnqq3noYErubXC93PaSYFYcjClJIvbZvVAf7HdeRK/C+r3gu+Yc
 7Oxamk0CXY7oDJKsk8bOm37s047Qe+zztXgeKYCYtWMGXTuxhywzoBqLud4iBEXQaOcR
 DqSi3in5GvuIPN/A0hplB2X4XM5ZDN5PiLiRqAaQAM9kQHT9o9SPGy9SGfZ0yL8wP+1Y
 vrR6u51erikmt2ov+kgzA1c45iMudEsqnM8FQ55fuuON3xke//4p2k/a/zhCpuBBNEoL
 2u5HB0eWHX6fXqYdnLTaH44jwxFF5pBOYueFbUFhGqkf1SBWx2v0fu1282DmJd31zlVh
 QTRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPAnuUdQqufHjCVwCOaWc/Om6zPUSS1VaMc32Y+PsQ0FkrwyMehAc7OGHw0ue5MGYjW+4xbAZaipl+@nongnu.org
X-Gm-Message-State: AOJu0Ywng+/6MGqxbu3CCW5xsxkbz1Cc8ZibYc3WeTicteCRyu7Px1OF
 6EhAl1ZLpwBIADCCfFfzjNVdT3Ir42yXIwtBADbU26R9/t90iNDhHAOWmhLYTrXB4gkLL4ZUh2e
 yRXMgQQ9F/k9JCNyf3oSnbxDEUAcITI2OSR8P0illTo1fQYlnq0+I
X-Gm-Gg: ASbGncv8WKrYVGi7jOVFVEIYotaxTgDA3S2dg29knzYpj+SYmG8zhn5hGwzD3xiWqJH
 M7hESL5cEmWkYnCoPK9p0judnlkMrV5ieWghjugSp19DIA5hZvVCA80HYJCvZRHp6Sy/LUkAE9g
 jMtZY2YPgkiTZrR5A/HTudn+IeY+hlTNfuSWq3vaMm+gnaqEuIjrg5EzLwSjzq+RWF0Nwq/jpuO
 b+lQje8fYAP3mY64ymlUoEFikp21maz4JcUMVuU9Ldx2EGxulYk2d0XA0gNSNVbyoyXLFGC8nVp
 UGF+lKupQAxWOpOguXmyWTXXEfl+J94=
X-Received: by 2002:a05:622a:1491:b0:467:79eb:4a16 with SMTP id
 d75a77b69052e-46e12a1e737mr308048711cf.4.1737576673066; 
 Wed, 22 Jan 2025 12:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGysv3nwwcSppba7iEOYVcw3m0mpfUM0hFEl7dflwR+MzNttLkCJwFJFfPDa5y3kz4iWAbHkQ==
X-Received: by 2002:a05:622a:1491:b0:467:79eb:4a16 with SMTP id
 d75a77b69052e-46e12a1e737mr308048371cf.4.1737576672677; 
 Wed, 22 Jan 2025 12:11:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10433f9fsm67104091cf.76.2025.01.22.12.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 12:11:11 -0800 (PST)
Date: Wed, 22 Jan 2025 15:11:09 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH v3 1/1] system/physmem: take into account fd_offset for
 file fallocate
Message-ID: <Z5FQ3Up1UeBL4dlx@x1n>
References: <20250122194053.3103617-1-william.roche@oracle.com>
 <20250122194053.3103617-2-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122194053.3103617-2-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 22, 2025 at 07:40:53PM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Punching a hole in a file with fallocate needs to take into account the
> fd_offset value for a correct file location.
> But guest_memfd internal use doesn't currently consider fd_offset.
> 
> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
> 
> Signed-off-by: William Roche <william.roche@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


