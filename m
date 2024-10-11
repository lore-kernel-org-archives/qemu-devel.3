Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D239D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJJ9-0003b9-2r; Fri, 11 Oct 2024 13:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1szJ86-0000wP-GZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:43 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1szE80-00020e-ET
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:48:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728647285; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LhvAQZVq6zQugAdDltO5fIFd+w4LbVTw1bsZ6HniKjHj/NEZxuueztbr2J3o7XmdlsSZXvXkWfutBYLP251hT/dqnxUKmr6JpYgkfcKVXlzGk4c3xf/cDKF2imPjDHYn1WMdSW9/y5fMbuV7tLXbjZLQMAuNHeRuDpAMpxKsXfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728647285;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=5sFyEQoNNfTMnrZMF9tqgJD3gpPzf6HZ6Qu2TFjkOfw=; 
 b=mg5eSFOHEbMJNhvL4zcXpKxTrfazTjOO+EM+fNWIDgmsCYuOU9+T9Vxz4DbsmLNXQvoevZm9Wl/h9jYaV/CGbbE4Sdu4adQENbtOjJPTCYGL/3uz0SxAdtl+SBxy8sEEcxLYmRoxWBsl6nLBtNhXdLK7ngjzWQr+phXptJjH01Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728647285; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=5sFyEQoNNfTMnrZMF9tqgJD3gpPzf6HZ6Qu2TFjkOfw=;
 b=ED5+4AIHsC7E2fAxCDaFi5uFq394+h5+nY1+ICnPAh+1BVHF80hnBlnEun3Zl0Uh
 NwgJLn6ux2RsdR63S0SMnODgcYIeKTMrSJCHsH56g2SmEtAzwWKBQrgfs4NpcrMP6H7
 peUb6uDUIDOgDTc5CfX/IGjcbiPfR11eFkTWmdKg=
Received: by mx.zohomail.com with SMTPS id 1728647284424419.6132558453404;
 Fri, 11 Oct 2024 04:48:04 -0700 (PDT)
Message-ID: <e5180507-82e0-4bd2-8418-15bb831130e2@collabora.com>
Date: Fri, 11 Oct 2024 14:48:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/13] Support blob memory and venus on qemu
To: Akihiro Suda <suda.kyoto@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <CAG8fp8Rbh6a+asyt1iowS2U=HE_qicxUGZC1vz8wHdtB0OtNmQ@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAG8fp8Rbh6a+asyt1iowS2U=HE_qicxUGZC1vz8wHdtB0OtNmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/24 03:59, Akihiro Suda wrote:
>> And I think this series is ready to merge once the tree re-opens.
> 
> Hi, is there any remaining blocker toward merging the patch set?

There is no blocker. Patches will be merged once Michael will do it.

Michael, please feel free to apply the patches to staging. Thanks in
advance!

-- 
Best regards,
Dmitry


