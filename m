Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9EC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 20:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf3Rv-0003IC-35; Mon, 03 Feb 2025 15:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3Rt-0003I3-6g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf3Rr-0000iF-HC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738616017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nnk3oTrr/QsusokbIIJFGije7AZyvalYc/y0LY6N2So=;
 b=Qto6U/COl5Fi0hWJ/osJ4V2o+nbz0y+6MdOZCmv1DnpBtML+IFXo9oGKN3VLRH98Y3PcGE
 9H1TeOW3J05ElkKOdm22Eo4EVmZ5wMQ4YejxSn7ggmkLhTNl0Ec6luhkMO1IGkhaVMMCu8
 Gp7nxxP2Qcqk8Koj+NGF3LoaFWm2Dgw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-gm3OP_0zOMmquzRhjZ2eIA-1; Mon, 03 Feb 2025 15:53:35 -0500
X-MC-Unique: gm3OP_0zOMmquzRhjZ2eIA-1
X-Mimecast-MFC-AGG-ID: gm3OP_0zOMmquzRhjZ2eIA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e42197595cso3163636d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 12:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738616015; x=1739220815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnk3oTrr/QsusokbIIJFGije7AZyvalYc/y0LY6N2So=;
 b=jbXCKIRQGNADV5MXDwHPzPNhcfT6q7WgBlOqMB6T8aclqeSkjny9b7HpZuebOBCEjF
 52d2xhuiljuq4I8GCZKaRpFr5HH6rbOql2kpyo/9kO0kJgnlUSZjLHYjFsPtuxldTYN3
 D0pbWXYiFvexyzgjvStYckkoTx7hrKDYVV7aeghXJ+FfN1WO7RiYqtppZFnwJepi53DC
 ukL0BGJj8TuCn722jTn3ex/WX2AEuduwrN/BXrgjEGFrOGLjArIanJCW0EzBQnUN8+8x
 +I5vDEseMxRdF4jNdjFmhUmn1hKVVP1mrSareRpWkdo6ZzvSlAo86Q5YEBiWTPl0//jR
 jLaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA4PzUPjLODeeXZ2ZQC+f9+yOYzK2GzonHnScUT9tRWnqCmRXlFgGeUEkRtfkJY1w2/SwaWRlLoNA6@nongnu.org
X-Gm-Message-State: AOJu0YwmeynnvAmZ5ObhRn0XrkgrAD2euzvGgExIFDmMCNEez+PDG0Xr
 gN0ESxqR1Z+j4IbTV43VwU+7zprVqa656Os+GQIEw8FMy9fEPSpbB1lU5qDuP1093xutBLbXSvI
 bR7THD8S5qOmvEdn5HE2s8Ir4DuaRdIVPu+x4depYIFYZ67LMgB6g
X-Gm-Gg: ASbGncutgQ6x/4T4cwfev56PuvuqMXkRsVK3Wp7vUtt+W2SPmR8EwjBj0UNcOz+8eE+
 G/rr0/otcPxv9/dhCFaeRIFwsyPOmyto1l9MtnZfF7isMeZUpW1GZ/2Ffe8Ienni6PnDSnzitLP
 KJCwu83iK3zwI2BDMnn3WvattKNh5o/wj6a5bA3uspH+QddqOxgueBN1zGvk1YEitdlv0vo5Z0E
 NskwebKMQyTxvNp6FIK8Ivot2A7KHyYtdIrbCk1JI6ez+Xx8NpBP6hBNVSrCm9hwecQvDpcda59
 guP/4+Nwpy/FOH/vSsmIxNDMGXyrZ9GM/dDsMQ/6P5KKslnf
X-Received: by 2002:a05:6214:5f12:b0:6e1:697c:d9b8 with SMTP id
 6a1803df08f44-6e243b93ce8mr323863816d6.9.1738616015362; 
 Mon, 03 Feb 2025 12:53:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3qWNgtWL2pDPWt4E2e566u19+bd0ows4cqlucmiq+TKx3fVMb0W64Ng+Oli2AGPZlV0lhDw==
X-Received: by 2002:a05:6214:5f12:b0:6e1:697c:d9b8 with SMTP id
 6a1803df08f44-6e243b93ce8mr323863616d6.9.1738616015128; 
 Mon, 03 Feb 2025 12:53:35 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922559sm53817746d6.75.2025.02.03.12.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:53:34 -0800 (PST)
Date: Mon, 3 Feb 2025 15:53:32 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 10/33] error: define g_autoptr() cleanup function for
 the Error type
Message-ID: <Z6EszCrXI3FRhYzA@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <82edf9cfc5f707be405c48a46a42a42df3611aaf.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82edf9cfc5f707be405c48a46a42a42df3611aaf.1738171076.git.maciej.szmigiero@oracle.com>
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

On Thu, Jan 30, 2025 at 11:08:31AM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Automatic memory management helps avoid memory safety issues.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


