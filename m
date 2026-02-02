Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2857E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmud2-0002vj-DY; Mon, 02 Feb 2026 09:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmud1-0002vR-FG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:10:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmud0-0001lr-3Z
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770041409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiUFFKvIWaEACAT68ds40xNGBXGEYn2qcCOOn0CoUxg=;
 b=TzZRm9FkARLDpAdipTh33aTG7XifWiqm53xfj9eNHLR3hBBb7Cc3ryBk//mkyTR6H7UyAv
 mlsWvLvUBFaY5yx42/bD2Ii/yn0CIoWnOVnUR5Nnsm7djmyj93BXGc6+BVXEmbGP+Iz3mc
 UQJ+17QMOOxC2qzWkbDoZtuMe+DzVJM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-DiLOec-xOzKovjWqAF8vIw-1; Mon, 02 Feb 2026 09:10:08 -0500
X-MC-Unique: DiLOec-xOzKovjWqAF8vIw-1
X-Mimecast-MFC-AGG-ID: DiLOec-xOzKovjWqAF8vIw_1770041407
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89462dd72a6so158304816d6.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770041407; x=1770646207; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AiUFFKvIWaEACAT68ds40xNGBXGEYn2qcCOOn0CoUxg=;
 b=oMeCR2z7A82GHPt0Fw7iDb5IaJ7uHyRGmw3OC8t2yeBUEB/Pv756jhNTUusAK3RAPu
 2jynzKywq8RYmcqfPEcIuOyobVmnfunftZD+m2jcx2PQih7CwNrk+6nzGJOCkVNqEeZx
 RISK8g/PbDqIeptRAV2Eu1uscsXKxz7l9hb9BmOmwIDFtTEQ3oedYwKEbqKE/Ajp8zOf
 c5lyYtrAYzC7nuVEqvhNdUBDrnCvkZvOqciGF8q2ZoMBrUzq8lFjWsQvWyg+/FJf5tKp
 P2yNWTaEnlvzWKnHYX3Odgn5kPwoNaLl9I99GwI+4SwimU8XzUKERQ4hHZX5lQQS3sZu
 BB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770041407; x=1770646207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AiUFFKvIWaEACAT68ds40xNGBXGEYn2qcCOOn0CoUxg=;
 b=cSTg8HjhCeiGvlChi8ze9Q/Aej7fkAzJsc3L0QHMiRmai0w4REIqBqrwSAeYViI+vD
 XnUKUI3XKffgcuhEY/VHDqk7KUTG+Az3jdwr/hGaWrXKyZvAbODoREYW5Ld822kJCcpF
 +vZ1gXn7HJtIR39y9RCtxhdKZF9UJFDFDPw7+6pn4CdAxDIX9FjhcfZU+DdWFaai3Obl
 BJzf9yhaljP5efgbZlmXzuHjjs2PyWBNlrVRgXmR6GEMTpBOuSBy/6x255ACkuiquaUS
 aB/60B5CIOKcyE3tW3acxtjM5RiOZHtj4uzsTcb/kw6PaANYUpGiNtfJZ+xqLvFPmfmm
 O9zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQc5LEDzr2Lge/SBS51z0F4sD+rqi12vOuJ7qdU8dsGIm2IKEpltljhQqiuSMGAp5ZcErOFvy3SPfy@nongnu.org
X-Gm-Message-State: AOJu0YwgaRmtTgMUx3sdEK0HsNE60XJAGGjPH1FqumwumiEuHMOX3Prj
 4OK8NE8vL/loFclUFvM8Vq3P6quFcAjrQWdo9myRNsYDZVOd6cltKwu21RDxinjuqhx0Hq6d37o
 VBRRuyoVShQ9mk7CSjAKqId6C4AImL1ODedwE40N1psC5oHBPuEb+H1O6
X-Gm-Gg: AZuq6aLKV/HrgVJt14hxSRivvxMxSQ/PS5gp3g1DULSix2sLS+j677elWlmLoKnav1X
 f0BMeL5Q9a/3XGDReaYTU2u1HnQi9qtfQqeY8sJjARC3qcZgJl/bddpW3/IYz3lgjeIFZxE1GX3
 u+IELX8Cc9PfSktF5yLexHPQamLD8E26W666GFpSlOcE1vODKaQwZPPxDZL/C3iNyNPsj/i4+G2
 QjB/cnvEKkoMB+GShv1M6dAlqa9q8rhE3SivqkerrLIU70lTyagu2g6McrZ5B4Mx9SCHV9S2LQ1
 gmTmnRZF6mTmbmzp9+LOG+PamZJ2hKBhOxMfvubRNRo0DzwWIeR9C+nO8KOwTfdMaXFFwutGgRI
 y6Kk=
X-Received: by 2002:ad4:5ce2:0:b0:894:7051:bda8 with SMTP id
 6a1803df08f44-894ea0a353fmr155515176d6.39.1770041407451; 
 Mon, 02 Feb 2026 06:10:07 -0800 (PST)
X-Received: by 2002:ad4:5ce2:0:b0:894:7051:bda8 with SMTP id
 6a1803df08f44-894ea0a353fmr155514466d6.39.1770041406846; 
 Mon, 02 Feb 2026 06:10:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d37412d4sm119935436d6.36.2026.02.02.06.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:10:06 -0800 (PST)
Date: Mon, 2 Feb 2026 09:10:05 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
Message-ID: <aYCwPZukFlEZgHFv@x1.local>
References: <20260201122348.28478-1-avihaih@nvidia.com>
 <0c48a2d5-776a-4cd7-a1ee-3cfc32dde931@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c48a2d5-776a-4cd7-a1ee-3cfc32dde931@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Feb 02, 2026 at 02:33:07PM +0100, Cédric Le Goater wrote:
> > +# @prepare-pre-copy-p2p: The device is just about to move to
> 
> Could you please rename to "pre-copy-p2p-prepare" ?
> 
> Peter, Fabiano,
> 
> Any preferences in the naming ? I would like to avoid
> "pre-pre-copy-p2p" but it is what this event looks like.

I'd also vote for pre-copy-p2p-prepare, as it also keeps making "pre-copy-"
to be the prefix.  No strong feelings.

Thanks,

-- 
Peter Xu


