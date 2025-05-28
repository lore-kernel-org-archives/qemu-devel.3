Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FE6C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKInt-0007T6-Lt; Wed, 28 May 2025 11:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKInq-0007Su-5V
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKInn-0005yn-QJ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748446483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmTsV0BLM+0nrLdyv6i+dQpfoxiVI6uodJ/W5avPfhQ=;
 b=LAgbM2CEyh+14OM5T55MJo6q1nrxSry+GN4919Kr8Y9unsD5i9LVARkcYfv2dEBA0YCJnd
 OFRdky8x9eWYkpJxjt0rGDCF9skcmd8O9XMcr7Krgzn6wM3y+EiWXA7b9QKQO5LXqNH3to
 Tfj4fzw2tK3AfrWZp2pappDzpnJsDyo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Vp3KjSqvPUathkpBinZkWg-1; Wed, 28 May 2025 11:34:41 -0400
X-MC-Unique: Vp3KjSqvPUathkpBinZkWg-1
X-Mimecast-MFC-AGG-ID: Vp3KjSqvPUathkpBinZkWg_1748446481
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faaa900d82so17758646d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 08:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748446480; x=1749051280;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmTsV0BLM+0nrLdyv6i+dQpfoxiVI6uodJ/W5avPfhQ=;
 b=nLM/6iL3HVvF9Yt+lkShAWEufRPmXoYAaQSl3l9vIlaVHrzkTftpdbP84hsqQgjoYX
 q0f7IpcI/V4oslsdDfjL47GJEJijTTk/n4Zw1JrjSCnSU/gIrNDig+j//3Y1wOrXrGPF
 S422fLQkLGz5Zin+xptVNys9+BWjwer1mBo60OGFRCFaluFQU3WFN21MkY2uY4Iyf7V2
 jra8oEgaHUjZoCN8AHZF0mvl23Fn6mVyt1kQBptZ81nc1HjTiczc+b5PC+A8lieoXUpV
 tlOZV+S6FvcUxT2WXrbPVMjeAOVDsnyON45QyJrPPEWDdMhbYgpbYaMLoUVxQlERdm/z
 27cA==
X-Gm-Message-State: AOJu0Yy0CTMUv+Nep7eNZg5U6iepp7nq9io21hDQ3PDIUZDzuMXmAwcM
 0SLjUdukG6mKiCpNW4lNO/2dLs2gkLaMKKl3IV9nLP0xsASJeJcQkhz3ggR3AgUJflj60WdKH+/
 FmmLdVDy179v4+NjKs1udXZn3XzRlTnuohYq6x2SXhpvVD49fcGR7taJbo3aENLrW
X-Gm-Gg: ASbGncu+nbPC62Ear5ZQC970S41qXiq7ZkP9S6Prv6RsaUKpRxaUtOTGzVCcYkqpwpz
 B7AMJX5Ox3fNs8PYDY/FtgThlbPe7er0fHPHPhur/WbUQd+yfzSI8E3hkvRlhNgsxtxSRrlJ7Y1
 S/YqHtdSAystIneSyWiBbWEFIDGZ0bEhr7HN4McjCLMxTtKHDOFUCoem5/0TSzHhQtIkGACHgjW
 W41DQUcrxbU/Pch/Ed5lebmqldP8BuxZC28azG/Hx7CNi1Wpl/8g6Cg0/l4MfM8ZEU84tkNDBbJ
 qAk=
X-Received: by 2002:a05:6214:d44:b0:6fa:b68a:99ed with SMTP id
 6a1803df08f44-6fab9eb0c44mr74944206d6.13.1748446480151; 
 Wed, 28 May 2025 08:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD9AEIiBdtACftTAXGw9NRovRtdDidMwCwnbKUv/8/HWPbRejOxkVbx5LuLwpFsaw9/fTv7A==
X-Received: by 2002:a05:6214:d44:b0:6fa:b68a:99ed with SMTP id
 6a1803df08f44-6fab9eb0c44mr74943816d6.13.1748446479728; 
 Wed, 28 May 2025 08:34:39 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac0b289c8sm7675076d6.47.2025.05.28.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:34:39 -0700 (PDT)
Date: Wed, 28 May 2025 11:34:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: virsh migrate fails when --copy-storage-all option is given!
Message-ID: <aDctC8i7U2J5bmyw@x1.local>
References: <31711771-7caa-4ea3-b763-45db6930e28e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31711771-7caa-4ea3-b763-45db6930e28e@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Copy Kevin.

On Wed, May 28, 2025 at 07:21:12PM +0530, Anushree Mathur wrote:
> Hi all,
> 
> 
> When I am trying to migrate the guest from host1 to host2 with the command
> line as follows:
> 
> date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
> --undefinesource --persistent --auto-converge --postcopy
> --copy-storage-all;date
> 
> and it fails with the following error message-
> 
> error: internal error: unable to execute QEMU command 'block-export-add':
> Block node is read-only
> 
> HOST ENV:
> 
> qemu : QEMU emulator version 9.2.2
> libvirt : libvirtd (libvirt) 11.1.0
> Seen with upstream qemu also
> 
> Steps to reproduce:
> 1) Start the guest1
> 2) Migrate it with the command as
> 
> date;virsh migrate --live --domain guest1 qemu+ssh://dest/system --verbose
> --undefinesource --persistent --auto-converge --postcopy
> --copy-storage-all;date
> 
> 3) It fails as follows:
> error: internal error: unable to execute QEMU command 'block-export-add':
> Block node is read-only
> 
> Things I analyzed-
> 1) This issue is not happening if I give --unsafe option in the virsh
> migrate command
> 
> 2) O/P of qemu-monitor command also shows ro as false
> 
> virsh qemu-monitor-command guest1 --pretty --cmd '{ "execute": "query-block"
> }'
> {
>   "return": [
>     {
>       "io-status": "ok",
>       "device": "",
>       "locked": false,
>       "removable": false,
>       "inserted": {
>         "iops_rd": 0,
>         "detect_zeroes": "off",
>         "image": {
>           "virtual-size": 21474836480,
>           "filename": "/home/Anu/guest_anu.qcow2",
>           "cluster-size": 65536,
>           "format": "qcow2",
>           "actual-size": 5226561536,
>           "format-specific": {
>             "type": "qcow2",
>             "data": {
>               "compat": "1.1",
>               "compression-type": "zlib",
>               "lazy-refcounts": false,
>               "refcount-bits": 16,
>               "corrupt": false,
>               "extended-l2": false
>             }
>           },
>           "dirty-flag": false
>         },
>         "iops_wr": 0,
>         "ro": false,
>         "node-name": "libvirt-1-format",
>         "backing_file_depth": 0,
>         "drv": "qcow2",
>         "iops": 0,
>         "bps_wr": 0,
>         "write_threshold": 0,
>         "encrypted": false,
>         "bps": 0,
>         "bps_rd": 0,
>         "cache": {
>           "no-flush": false,
>           "direct": false,
>           "writeback": true
>         },
>         "file": "/home/Anu/guest_anu.qcow2"
>       },
>       "qdev": "/machine/peripheral/virtio-disk0/virtio-backend",
>       "type": "unknown"
>     }
>   ],
>   "id": "libvirt-26"
> }
> 
> 
> 3) Guest doesn't have any readonly
> 
> virsh dumpxml guest1 | grep readonly
> 
> 4) Tried giving the proper permissions also
> 
> -rwxrwxrwx. 1 qemu qemu 4.9G Apr 28 15:06 guest_anu.qcow2
> 
> 5) Checked for the permission of the pool also that is also proper!
> 
> 6) Found 1 older bug similar to this, pasting the link for reference:
> 
> 
> https://patchwork.kernel.org/project/qemu-devel/patch/20170811164854.GG4162@localhost.localdomain/
> 
> 
> 
> Thanks,
> Anushree-Mathur
> 
> 

-- 
Peter Xu


