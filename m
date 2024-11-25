Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF270D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUkl-0008Po-LF; Mon, 25 Nov 2024 03:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUki-0008PL-RJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:47:29 -0500
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUkg-0005Ne-NT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:47:28 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.98])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XxfTm07r0z10Ym;
 Mon, 25 Nov 2024 08:47:24 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 09:47:23 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004d3c38113-41d6-493b-a9ad-d9b41f2bfc47,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 09:47:17 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 1/6] tests/9p: add 'use-after-unlink' test
Message-ID: <20241125094717.50e0344b@bahia>
In-Reply-To: <3d6449d4df25bcdd3e807eff169f46f1385e5257.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <3d6449d4df25bcdd3e807eff169f46f1385e5257.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 89b7e42d-70c6-49bf-b267-de1e671fe25d
X-Ovh-Tracer-Id: 4150911485057800669
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtuddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=qchhKHFOU1S+U6JPlA/xvmQ7hSOHGeQfZsDLKScdBhg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732524444; v=1;
 b=F/ozCWwrj3SO1iOsKMMKzfg75zOcwB7DtugKYxnHYUDFBHp35VHXaRFaRbZgYJoFg0+CDiK6
 qX3tJUkOqpi+lMD1dk3dDH5swi5tGYu+1nB/6xHJXlGMLx04IfDteJPHON1gZZ6s9JQwWANGOei
 N2EmenlUfwDvasfxZFTg4oS+/4XtGQurRzgY28TDLgC79V4e/Hlb19ndFFipUEz/z1WtePzSZkK
 K+FevchCQCoyS7oTAek4s0X4y1f+CKMVdjYxsJWueoZG+N7e/qeK/E0iBAAuiVy8pCHtSFGx7AS
 yA/WeoJlJ9EzjJkgO9PFB2jmwAm+yk/eT1VjJ/LeuhCOQ==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=groug@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Christian,

On Wed, 21 Feb 2024 15:13:13 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> After removing a file from the file system, we should still be able to
> work with the file if we already had it open before removal.
> 
> As a first step we verify that it is possible to write to an unlinked
> file, as this is what already works. This test is extended later on
> after having fixed other use cases after unlink that are not working
> yet.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Test looks good but make sure it is merged last to preserve bisect.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 41 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 3c8cd235cf..f6d7400a87 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -693,6 +693,45 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
>      g_assert(stat(real_file, &st_real) == 0);
>  }
>  
> +static void fs_use_after_unlink(void *obj, void *data,
> +                                QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    v9fs_set_allocator(t_alloc);
> +    static const uint32_t write_count = P9_MAX_SIZE / 2;
> +    g_autofree char *real_file = virtio_9p_test_path("09/doa_file");
> +    g_autofree char *buf = g_malloc0(write_count);
> +    struct stat st_file;
> +    uint32_t fid_file;
> +    uint32_t count;
> +
> +    tattach({ .client = v9p });
> +
> +    /* create a file "09/doa_file" and make sure it exists and is regular */
> +    tmkdir({ .client = v9p, .atPath = "/", .name = "09" });
> +    tlcreate({ .client = v9p, .atPath = "09", .name = "doa_file" });
> +    g_assert(stat(real_file, &st_file) == 0);
> +    g_assert((st_file.st_mode & S_IFMT) == S_IFREG);
> +
> +    /* request a FID for that regular file that we can work with next */
> +    fid_file = twalk({
> +        .client = v9p, .fid = 0, .path = "09/doa_file"
> +    }).newfid;
> +    g_assert(fid_file != 0);
> +
> +    /* now first open the file in write mode before ... */
> +    tlopen({ .client = v9p, .fid = fid_file, .flags = O_WRONLY });
> +    /* ... removing the file from file system */
> +    tunlinkat({ .client = v9p, .atPath = "09", .name = "doa_file" });
> +
> +    /* file is removed, but we still have it open, so this should succeed */
> +    count = twrite({
> +        .client = v9p, .fid = fid_file, .offset = 0, .count = write_count,
> +        .data = buf
> +    }).count;
> +    g_assert_cmpint(count, ==, write_count);
> +}
> +
>  static void cleanup_9p_local_driver(void *data)
>  {
>      /* remove previously created test dir when test is completed */
> @@ -758,6 +797,8 @@ static void register_virtio_9p_test(void)
>      qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
>      qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
>                   &opts);
> +    qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
> +                 &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


Cheers,

-- 
Greg

