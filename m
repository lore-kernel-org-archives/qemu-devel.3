Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C1C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 21:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf3zK-0004me-IK; Mon, 03 Feb 2025 16:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3zG-0004mQ-So
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3zD-0004BY-RO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738618083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fF14S8Iq6W4q9ykC7Wm2D6cXUtlEgEnNaUh+1EKSwMs=;
 b=f34w4zXV4htXBekh6HGA61BPoCJUHcUx4e99cu8aUMTZk6WJCSDbwHSSeoCWzZzOEz6s7c
 bVQ3MSzSb9I5KQHTu127lLP5u/2Wmnl+Bh8Dvz/awSKngQnjTMVZS8LhkNDrGnpMNjto/Y
 cJPK8J0hrOcMOVJJGn4eRKLKxX9865g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-xKEUAgBEOzOzNoeXTEHr4A-1; Mon, 03 Feb 2025 16:28:00 -0500
X-MC-Unique: xKEUAgBEOzOzNoeXTEHr4A-1
X-Mimecast-MFC-AGG-ID: xKEUAgBEOzOzNoeXTEHr4A
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1b037d5so854808285a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 13:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738618080; x=1739222880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF14S8Iq6W4q9ykC7Wm2D6cXUtlEgEnNaUh+1EKSwMs=;
 b=R1cOszCwshlh3Fb2B7acRRNS0daDCc5AnqqCL+XMw0g5SckQXF/dec0u4tv5EXXtaX
 aGtISUM5JHeuvzwuJex/qENz3J8OBSStdWDhn9SoJCWNhMKoYql2bwT/tomN6tkXoQAu
 4ziyCXEimxTloG9NFohMX/8WLIbld/A4siPMqOBGnwGkqvfK1az3dL+5ff4YpbuNsFFG
 D+TCVGz8TvnmO8ofGRCldB7dKbM1Z01hfZN0aG5R6UAqahNho06Iy/kKdt7pFv/iJOFt
 GAhLLiZxLT0o6JFZ3SU+pn/OtBczbSmoPTG+LgYRLyywhNrKnFosmn5sx8BgSaNkvY1+
 guFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW09Qh7bhX3V+0vnPe4yN7q0w3+RfCYzkTE5HHaoSHVEQ3GebVEY/pf3SAsQB4HMMmx2v0Z+87GBT5t@nongnu.org
X-Gm-Message-State: AOJu0YwNPr02eP76mOoDxGmHZxOzHSYC0vcCLWNXY0Bh9QXRtmydYBqM
 +3+Gtm9L2HgO+lIXU1mjrhVaSxg6WNC3zs3ux55whxrPfqVzYcnAelaAgIDH3SCDdXWe1FpSJD7
 vZRc8+KosZJMBbJcA0oOPPLCNfVex8byRdqRH+NttrpMZJWmI6pu1
X-Gm-Gg: ASbGncu18LE0hh6CdDzzRwGijUkz64tMRmYF7zvwow4lnNUKTcq/JyQIDon2wtjN248
 Y4cQ7m0Fq+xVn2eefgjm/gZNLQRE927HpAcbeS2/gnlbjSRdeyXFPUytJg9wGVaCh+EpwKTBmEE
 abaIEOeckF/GzMyURt27k7BgGe5giPD8jiMuBX3CQhHtWL5z0JU9F9RbEDS5XL42UeDLwCiSLbV
 pgVrX4iyFDr5d3Dpx+c6PtncaHi7MJabwSRuZevXbWR/y/bhFoRAJxMGdfmHjJyuaCFKJYk5Rsf
 Z/mt/OjkiBCz6XHGrb22COXYmOIOIzLct5B3oxOeoc/XTzeI
X-Received: by 2002:a05:620a:4382:b0:7b1:56f0:e09f with SMTP id
 af79cd13be357-7bffcda14b6mr4255546985a.54.1738618080426; 
 Mon, 03 Feb 2025 13:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1zCgqgZxZtFrO7jlfF6cN5ui2mSbaN5e/IQ2dhuecLyKyFovN81cr6t5gmwDxrOL0+/oskQ==
X-Received: by 2002:a05:620a:4382:b0:7b1:56f0:e09f with SMTP id
 af79cd13be357-7bffcda14b6mr4255543585a.54.1738618080146; 
 Mon, 03 Feb 2025 13:28:00 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d95cdsm568351485a.56.2025.02.03.13.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 13:27:59 -0800 (PST)
Date: Mon, 3 Feb 2025 16:27:56 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/33] migration/multifd: Device state transfer
 support - receive side
Message-ID: <Z6E03MMQqTDNFsnX@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <654768fd717b0def70906bf7adfd6739cfd2ecf3.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <654768fd717b0def70906bf7adfd6739cfd2ecf3.1738171076.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 30, 2025 at 11:08:34AM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add a basic support for receiving device state via multifd channels -
> channels that are shared with RAM transfers.
> 
> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
> packet header either device state (MultiFDPacketDeviceState_t) or RAM
> data (existing MultiFDPacket_t) is read.
> 
> The received device state data is provided to
> qemu_loadvm_load_state_buffer() function for processing in the
> device's load_state_buffer handler.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

I think I acked this one.  You could keep my R-b if...

[...]

> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9e4baa066312..abf3acdcee40 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -62,6 +62,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  #define MULTIFD_FLAG_UADK (8 << 1)
>  #define MULTIFD_FLAG_QATZIP (16 << 1)
>  
> +/*
> + * If set it means that this packet contains device state
> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
> + */
> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 6)

... if this won't conflict with MULTIFD_FLAG_QATZIP.

I think we should stick with one way to write it, then when rebase you can
see such conflicts - either your patch uses 32 << 1, or perhaps we should
start to switch to BIT() for all above instead..

-- 
Peter Xu


