Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A069BCA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFay-0007lK-3u; Tue, 20 Jan 2026 12:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFak-0007gH-Nq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viFaj-0004EN-48
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F6h+s7JHj4y5CEIX3cDgU1YNf6U2ny+ot0Az6p0zctE=;
 b=IimsFQoJS9+l5Ha47rt4+4ACJTJyE47wtW8Zp9UeapbMRUI1ResD1/TRndddDtCo+KFbmn
 j6OeMT5rc1iVsdMU3F0Xy2rZ+KTjAZuqGP4indkP1DjjFTNTGxp1FwIKCoFJt+0JiaPNxW
 G4Mo3w3wr7p6ZHpAnEkWfAVJtln3lM4=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-tFwOGJBFON2OjtpntJsPXw-1; Tue, 20 Jan 2026 12:32:26 -0500
X-MC-Unique: tFwOGJBFON2OjtpntJsPXw-1
X-Mimecast-MFC-AGG-ID: tFwOGJBFON2OjtpntJsPXw_1768930345
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ac34c4b41fso36522eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930345; x=1769535145; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F6h+s7JHj4y5CEIX3cDgU1YNf6U2ny+ot0Az6p0zctE=;
 b=ASOWQopvVxkpjF0zdFal1tvK0CbkbNHdzAPj1U0tjHdTuUi5hIBY+VsPA1wzUy7Dfu
 G6rG5wAqi0TArKm5d2TWOhjXE7ujfybgU4n9LPL9lDJ1ZzpKQ038A2iZrb/ruNON2ZQl
 UWarvtMewFOWBATCQrrF2LfC90ElKoKIJk+1fQCFudDjGD3lzEfDCYymyuxbDbRWrGCZ
 8ZZ3YjLq2MPT44M6rKCwL1L3eBWIZoMPBgTjIcGAHfsZeTQRzf5dhWdk4r9L1ZvfULfk
 2SCCqg2s6Cw3u932t7KNO675nrFnIwoNJQcIpUa5zb161mkQXInkV7pFIp/a8PVp3/Cr
 FlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930345; x=1769535145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6h+s7JHj4y5CEIX3cDgU1YNf6U2ny+ot0Az6p0zctE=;
 b=cGycK/x07Vb8bMQPK1tvpdhg10iQ3X0MZrmKDR2e4gGMMLi2uhvLi6QY7l/0pPHuQv
 Z7U5LzEoe2XmxAdyJ8o+AZE/I+RJ3A+cC0HI+iHdT66wRtipUYkK2Zoxdv6m9l98y+/w
 CpRc7Hp7eE0XwT4pzSnMTmldrqzUCWek80gjpMMC5qoEx9UEzzcXslWPSWL6w3UduIQZ
 3SN47fWz4O4tZawWHZAWj5YTIaDJUZ7d3iu1IkRwooZ9QT0JI5Dh47o5BEEDQfkU7cMB
 zNmlKM5sIpE0NCwewrRa3jBx+WuC9np+IGjvUqOML82NWUurL1nOJYvt8TziZCBshsNI
 6AEQ==
X-Gm-Message-State: AOJu0YzjonrdvFkm7nC8S9saKdPD/UFZF1mABA0IJD956CiWk/uX8RGK
 ueHIMhbmbVA9Lsi4KCCvLuOQEzbJVQ6RBIkdv2CALbQrkmDgwApRJaIv5kzNX39Bz3N8mBG8lho
 JQFIIff+rWAvWw+jHIeef8A52CQQa6rjONtniLnMAAY8aeKFWFwd2nSH6
X-Gm-Gg: AZuq6aLz4fbwvsObyWNGDJU+GyXU9fIStuseI06ctW0xdYNyhMotasluoqJ47uw1jsM
 WEfHVhBikzueYEbdYbW7gr3yAN7AqymEXSFVQF128wextVZY6CucdVFzubLCeCSrS+383LTcLWc
 k2Btl+yMesHTejqQeuG/THQMxhWy+IF/kvhIqVDx1CvLJ0vsDjO39FGlm9fTeNHmZ2rPBXLDpo0
 FDDXeXN22KYcslkKnYVCdRK/U2r9hxNdDoEysPb3fh2PH11SF1EopFETuEVGFrdZnFlxgx1tzsy
 a9eJocD6RkntqAl11vb5C4QJNK4Ao1z4qf9gvNYRTC9B8wNuKd0JLz//q7bbrmGE3J36OzWpCkm
 Q5Po=
X-Received: by 2002:a05:7300:30c8:b0:2b4:5618:be67 with SMTP id
 5a478bee46e88-2b6b3498c2dmr13766921eec.5.1768930344521; 
 Tue, 20 Jan 2026 09:32:24 -0800 (PST)
X-Received: by 2002:a05:7300:30c8:b0:2b4:5618:be67 with SMTP id
 5a478bee46e88-2b6b3498c2dmr13766886eec.5.1768930343819; 
 Tue, 20 Jan 2026 09:32:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7047b099bsm1945563eec.31.2026.01.20.09.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 09:32:23 -0800 (PST)
Date: Tue, 20 Jan 2026 12:32:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 8/8] qemu-colo.rst: Simplify the block replication setup
Message-ID: <aW-8IBvujjjPP2_Z@x1.local>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-8-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117-colo_unit_test_multifd-v2-8-ab521777fa51@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Jan 17, 2026 at 03:09:15PM +0100, Lukas Straub wrote:
> On the primary side we don't actually need the replication
> block driver, since it only passes trough all IO.
> So simplify the setup and also use 'blockdev-add' instead of
> 'human-monitor-command'.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Tested-by: Lukas Straub <lukasstraub2@web.de>

We can drop this line; Tested-by is normally not used on one's own patch.
Proposer should always test one's own patch..

I'll leave it to Chen and others to review this patch.  Please consider
copy Zhijian and Dave when you repost; you'll get higher chance to get it
reviewed.

Thanks,

> ---
>  docs/system/qemu-colo.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> index 2052e207e57afdd3ab3ab1a447d55f5e2e5b5b87..7e361998d871b2c9a0e8065a15c004a9d841958b 100644
> --- a/docs/system/qemu-colo.rst
> +++ b/docs/system/qemu-colo.rst
> @@ -233,8 +233,8 @@ Note:
>  **4.** On Primary VM's QEMU monitor, issue command::
>  
>      {"execute":"qmp_capabilities"}
> -    {"execute": "human-monitor-command", "arguments": {"command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "nbd0" } }
>      {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
>      {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
>  
> @@ -262,7 +262,7 @@ Primary Failover
>  The Secondary died, resume on the Primary::
>  
>      {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "child": "children.1"} }
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_del replication0" } }
> +    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
>      {"execute": "object-del", "arguments":{ "id": "comp0" } }
>      {"execute": "object-del", "arguments":{ "id": "iothread1" } }
>      {"execute": "object-del", "arguments":{ "id": "m0" } }
> @@ -302,8 +302,8 @@ Wait until disk is synced, then::
>      {"execute": "stop"}
>      {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
>  
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.2,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "nbd0" } }
>  
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
> @@ -334,8 +334,8 @@ Wait until disk is synced, then::
>      {"execute": "stop"}
>      {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
>  
> -    {"execute": "human-monitor-command", "arguments":{ "command-line": "drive_add -n buddy driver=replication,mode=primary,file.driver=nbd,file.host=127.0.0.1,file.port=9999,file.export=parent0,node-name=replication0"}}
> -    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "replication0" } }
> +    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
> +    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "node": "nbd0" } }
>  
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id": "m0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
>      {"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", "id": "redire0", "insert": "before", "position": "id=rew0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } }
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


