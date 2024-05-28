Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BBFC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmE4-0001Zw-Dt; Mon, 27 May 2024 22:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmDx-0001VR-Qf
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:06:01 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1sBmDh-0006Mk-D0
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:06:01 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240528020528epoutp02b7aeb2c2e590a0fbc1c1a6e4b647901f~ThNPNJmHc0653006530epoutp02Z
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 02:05:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240528020528epoutp02b7aeb2c2e590a0fbc1c1a6e4b647901f~ThNPNJmHc0653006530epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1716861928;
 bh=1U5dgfl29Y9KuKRKABUypiOSC5NqovxjCjMBcFzv1HE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lz01wrJMzLC4CYIymgyOXSmduv7KJEuLkTmqqxbPeMIESTMBWhSsAmmJ9tYMdp++b
 uRuTrvVGFIV3Fy1L1iHfcb+q05BLccYC+48kr+9XL/+ecSXHwFE0Hn+97EafNmS4lj
 iFfUICKB8GTXzdrO2OZLkTC8gXxFayTL7iprzJgQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240528020527epcas2p4130bc61849521e77877accff8e088d7a~ThNO4k2hL1562315623epcas2p4T;
 Tue, 28 May 2024 02:05:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VpG7W0YLvz4x9Q0; Tue, 28 May
 2024 02:05:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B7.F1.09848.6EB35566; Tue, 28 May 2024 11:05:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20240528020526epcas2p166104f4f2c41c0d52251974f5801de0d~ThNNyZgC62441324413epcas2p1j;
 Tue, 28 May 2024 02:05:26 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240528020526epsmtrp20c73fea573075a1c86bf01176d15df0f~ThNNxp1pW2651226512epsmtrp2G;
 Tue, 28 May 2024 02:05:26 +0000 (GMT)
X-AuditID: b6c32a45-447fe70000002678-0a-66553be6c85f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C5.49.18846.6EB35566; Tue, 28 May 2024 11:05:26 +0900 (KST)
Received: from localhost (unknown [10.229.54.230]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240528020526epsmtip1ed3c655d7bb1c2db5c72d1d4acdf62bd~ThNNoZZpe1755417554epsmtip1Y;
 Tue, 28 May 2024 02:05:26 +0000 (GMT)
Date: Tue, 28 May 2024 10:54:13 +0900
From: Minwoo Im <minwoo.im@samsung.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com, Jeuk
 Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: Re: [PATCH 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
Message-ID: <ZlU5RbH9aV8fji8q@localhost>
MIME-Version: 1.0
In-Reply-To: <dd406b1d-94d2-4b4e-8053-07d8237994df@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQveZdWiawdUeK4ubB3YyWTy4289o
 0fdkDpPF/a3XGC2WXEy1eHb6ALPFrHftbBbHe3ewOHB47Jx1l93jybXNTB7v911l8+jbsoox
 gCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
 hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBh
 QnbG9v0L2Qs6+Sr+Nl5hbGD8wdXFyMEhIWAi8X5uRhcjF4eQwA5GiVX3rzNDOJ8YJZav3s4O
 5zzadwbI4QTrePFhF5gtJLCTUWLmmRyIoueMEm+fTGAESbAIqEr0935nAbHZBNQlGqa+ArNF
 BJQlLl96xwjSwCxwgVHi/d53TCB3CAvYSez9zQVSwyugIXHiYRsrhC0ocXLmE7BeTgFbiRUf
 PrGC9EoIvGWX6Hh7jh3iBxeJq/3VEMcJS7w6vgXqUCmJz+/2skHY5RI/30xihLArJA7Ous0G
 0Wovce15CkiYWSBDYtvDfcwQYWWJI7dYIMJ8Eh2H/0It4pXoaBOCGKIs8fHQIWYIW1Ji+aXX
 UIs8JJ5O+M8ICZEvjBK/ZrewT2CUm4XkmVlIts0CGsssoCmxfpc+hCktsfwfB5LoAkbWVYxi
 qQXFuempxUYFhvDITc7P3cQITpFarjsYJ7/9oHeIkYmD8RCjBAezkgivyLzANCHelMTKqtSi
 /Pii0pzU4kOMpsCImcgsJZqcD0zSeSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YW
 pBbB9DFxcEo1MDklWR3fl9VdeUaJ83vPBd057A5SFYv3F6/hz//lxjA5aOZj/l2zmW9P3jOl
 wr0gfYHdygP57sWX/jtOXajwua91ypZWr9yv53av/Duvc9maLUWrwmyybZN7uRq1pHa3dT6c
 p21j4POl+KiPxHYely7dtrpwxTsVLevYvHjK169k5ax25V7MtPPw+twpNr/9Xq5ryGYoWCl4
 5aP0p7d79lyX9XpbniczdanJZj7RWsvGIKVkQYlVlqXSRxNvPbBVsooTEFmoUc2VlqMuoGx5
 aXOIdcDGbXNKYmee+LT8wVmWvlSuy8/ZAx76s5693L6tccHXOp2HMc13quqVw6Q/6excIpuv
 w3gu06h2c16EEktxRqKhFnNRcSIAdsjquhoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnO4z69A0gwsrlC1uHtjJZPHgbj+j
 Rd+TOUwW97deY7RYcjHV4tnpA8wWs961s1kc793B4sDhsXPWXXaPJ9c2M3m833eVzaNvyyrG
 AJYoLpuU1JzMstQifbsErox7V16xF5zhrph7/hhzA+MVji5GTg4JAROJFx92sXcxcnEICWxn
 lDj2vIMNIiEpse/0TVYIW1jifssRVoiip4wS3RNamEASLAKqEv2931lAbDYBdYmGqa/AbBEB
 ZYnLl94xgjQwC1xglLj5YSJQgoNDWMBOYu9vLpAaXgENiRMP26CGfmGUOHihlxUiIShxcuYT
 sEHMQEP/zLvEDNLLLCAtsfwf2NWcArYSKz58Yp3AKDALSccsJB2zEDoWMDKvYhRNLSjOTc9N
 LjDUK07MLS7NS9dLzs/dxAgOcq2gHYzL1v/VO8TIxMF4iFGCg1lJhFdkXmCaEG9KYmVValF+
 fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA1Ppkv3Tf0wNuzQtbMIfp6ad
 v2YzTHyvfXX2rBvJwpOvLHiyXTn1aYLYRxZrg6yQBLMzf/4aJETXNYsJHBLYdLfnyJTn7rPP
 3PS9uCkwRtwvNPnIJ4Nc/Yr6O/k77dPvrNr/4viMuO7PfQFdyidWSUdas52cEFXM7lnv4Km0
 X9nohXgdz/eJK4K8bl869EfqjMLWO4F8yYq1jWIqV2avSt5y/em2HzMv1dqz3/ZKNHm47YJv
 Rn7fGsNtx2xZtSdafoxqu/ZgidCh0P8KQjmMV1NMJiZn99hNPedaq+pQt/Ld2i0z4iqe8wjE
 v4/1ju/n1nKW0NSIqIr3UMwQ10w6qP/jxsmrKj0Lek+2pR3LTVRiKc5INNRiLipOBACSbnxh
 4QIAAA==
X-CMS-MailID: 20240528020526epcas2p166104f4f2c41c0d52251974f5801de0d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----gt1.qfElKZAoa8EXYHmYdq7P0_WXC.LTuOUU3vcNsO8EXMAS=_750eb_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92
References: <20240521110544.258772-1-minwoo.im@samsung.com>
 <CGME20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92@epcas2p4.samsung.com>
 <20240521110544.258772-3-minwoo.im@samsung.com>
 <dd406b1d-94d2-4b4e-8053-07d8237994df@gmail.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=minwoo.im@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

------gt1.qfElKZAoa8EXYHmYdq7P0_WXC.LTuOUU3vcNsO8EXMAS=_750eb_
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline

On 24-05-28 10:00:35, Jeuk Kim wrote:
> Thanks for your contribution!
> 
> There are only two minor comments.

Thanks for your review.

> 
> Please check it and send patch v2.
> 
> 
> Thank you!
> 
> On 5/21/2024 8:05 PM, Minwoo Im wrote:
> > @@ -1288,12 +1717,21 @@ static void ufs_exit(PCIDevice *pci_dev)
> >           ufs_clear_req(&u->req_list[i]);
> >       }
> >       g_free(u->req_list);
> > +
> > +    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
> > +        ufs_mcq_delete_sq(u, i);
> 
> Isn't it possible that trace_ufs_err_mcq_delete_cq_not_exists is printed
> even in a normal shutdown situation?
> 
> If true, please fix it so that the ufs_err log is not printed in normal
> situation.

I will make sure that the normal shut-down case will not print out the error
event trace.

> 
> > +    }
> > +    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
> > +        ufs_mcq_delete_cq(u, i);
> > +    }
> >   }
> >   static Property ufs_props[] = {
> >       DEFINE_PROP_STRING("serial", UfsHc, params.serial),
> >       DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
> >       DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
> > +    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
> > +    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 1),
> Please change this value to a value greater than or equal to 2.

Oh yeah, it should be to support device command handling in MCQ mode.  I will
update it in v2.

------gt1.qfElKZAoa8EXYHmYdq7P0_WXC.LTuOUU3vcNsO8EXMAS=_750eb_
Content-Type: text/plain; charset="utf-8"


------gt1.qfElKZAoa8EXYHmYdq7P0_WXC.LTuOUU3vcNsO8EXMAS=_750eb_--

