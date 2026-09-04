Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906AAC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Wt5-0002U5-0G; Fri, 04 Sep 2026 12:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1x2Wt3-0002Qc-Ap
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:35:33 -0400
Received: from mail-qk2-x10.google.com ([2607:f8b0:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1x2Wt1-0004DK-Bf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:35:33 -0400
Received: by mail-qk2-x10.google.com with SMTP id
 d75a77b69052e-52e843c64b8so293041cf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788539730; cv=none;
 d=google.com; s=arc-20260327;
 b=rw0rP28FoZ6lnkKu8D1DLjy3iYbfuT/VXYT4IgfYlLhWsNxjAxGK9rKn6g3wVBypca
 wXXJIus6a+j+UPzdBMpOBIUQ2FXu2gC9iTGUhpCnsiSeRSSyedyw6J4Smm6BYiG6TS9U
 WO7N+zRWm4/lQj11th3L2yYxhbiy5NwN0dtPBKjaRBJZw5PIABWBnFj0KHgg9vSFIeUs
 YHcEoafiu0UAprx+VGMcl4CKgKBX4vERkRPmvjUQAXkTdmpa79e+jz7Y8MmPTsK3NOoc
 7dwkgF3KBu9wE/5rk1uhPlWrdQ+pS3aVR4pdQHI44foCHYSqF+LKsI97h4tBv1FDbDcV
 b0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kkkWir0hpmL+Y3ZjCd1bFaYasm1AlfBsGTjXyoDyFRM=;
 fh=KY4iSIvi5Jb/nm7e2MRTNVDqflN8B404np/L/XjplCE=;
 b=Ee9vhRrlsM6qIpupcbzyeQktg70LD9govXcf6vjdDVDvA3wKzDxYWl0k/QO6rj3Gzc
 n6QfqocRSlwiCiRrDHxhbccLmFLT0xZWeGJmTxPkYxDA4ypa1bgx9sk0Tx/HTCleTebW
 g7GdNy6AJnmTyfEqt0ZzGb2Q+R043tuNNCiGXhZxraIOFkFqyy8aLWpVbLZCcyO/D6Gg
 km4LEaavGyz5uAzz+yRRiq7oRbMiOJ3CXm14+EXBnKpH82+AZeOJKvxiDLy9sArKbjEV
 gHa/QPszlJEOHsaRHFzT/i/U9JoVipNu1xWTnwfEZ49OAvF6dSWt+4TfG/9tGi8E7IGJ
 aV+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788539730; x=1789144530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kkkWir0hpmL+Y3ZjCd1bFaYasm1AlfBsGTjXyoDyFRM=;
 b=j1TOMGCTa+b9o0H9A0mo6uThssqDVA1AA7KU5hl0w7lGaZR/fyfCJJorbRWutdJuR9
 Sh9A2Ntcq7mE4ktfT298URcc76Q2NpS2TAtk8UwqnrpwY0OLjuzkgV6gxXtnw0HXyEFq
 IrW1XHwJ5eNYbN/b3ynK7skeDetrSTJWrLqn89NinHcVcg7+1IL/hGnUoxyrmtQ0y0Ct
 ptIr1iSfKaIZNM5LbATdZ0ACXieLsMiI29IRuDyjIEbA9DZLRadApCyqG6knlZwwtFii
 85QmBWWqLf12vsNOGMB+Y6gZsHwkiBpr8thh16ALP4Ujkzd/vhOLvqSWFDOvvq6+mU7i
 B4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539730; x=1789144530;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kkkWir0hpmL+Y3ZjCd1bFaYasm1AlfBsGTjXyoDyFRM=;
 b=MO1KnJhYMZALA0FaPgXgTSH3+/s8V52o0Mp0JJMFlerf+ZnSU+JOfBhNEwvsboKAPG
 r07YAEPTzCy5mJTj3DHFjzQieLPllzOdXzlg84HFrVCuLC8kj/7fqN7OlBUR67dxTEhb
 rcC+lJuZTpu0Ymw6qJ/8RqI4NuKwwiREYEi2bPBHyaIfXpxIkA8ZQX3slhvoxQDx3izT
 qvXR1ctygrDT926afSkp5ySgCh4epCTmPnByk+kdO79T4iawHhmpMR87wZqbANNoEL1X
 bXgWhppQt/M5e3iHTDDGikKO3LPasIH6QZ+6hU/CG82TbRn3Wus90NdJt/vCMcJG1WkU
 iRfw==
X-Gm-Message-State: AFuF++nOW7pVtoRQL8s+wrseXMytLFmT5BLbl8Kz0ssMbbvcn/R+2PMQ
 zzTjv6s5pHmHn7y6LmCfWzCVK8W7iVO/zbbBMlwDEwXdrHK+cWWpTlo1gCcTbXoMWhDLJT90ouN
 6Sc3k/C8xAdwswYf0f6FO+jLkw41iyiQMDoOMDk3o
X-Gm-Gg: AYBFou0kCN57NqYLxGmeQ/zGLpxSNEHCpCec87fhMoEvu36K1mfitD2wOGsercqp4BS
 9E8HDbvGapJvvRZupj+hPh71gN7/+k+2sw/II3gnH9Nb9AYy1piBROm6H2WUTL/eNDtg/ovWikv
 +A6higBoNLWfqDh0cj+fp94nmI5obLB5mk5qIS3q0/5/C66ZYt3Ya/fOX73v75hPxAEzZ/SoLXS
 0A+tcQERzghfhJUyVb/R2dxK5mk6+MccTfLAL4RhtLQYL63T+i4Vv0dusTkEcOJykHEb0PsvdP7
 63gpDPxYq91yp24z4MyQN5AO4WqyKbkDi5inAQ1nhm5GwA8Q9wfZd4DcYJBEkQ8PreI4LDWfdNA
 =
X-Received: by 2002:a05:622a:449:b0:52e:8422:a329 with SMTP id
 d75a77b69052e-530559cd378mr18251481cf.6.1788539729389; Fri, 04 Sep 2026
 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260826050039.2068138-1-namangulati@google.com>
 <CAMP57yUuJUrpPtvf6Nf5SoDZ7Z+dfXFmHB-0AJ+vhzysjvgxYQ@mail.gmail.com>
 <135d159a-2117-4595-ac6c-4d0ff4c843a9@redhat.com>
In-Reply-To: <135d159a-2117-4595-ac6c-4d0ff4c843a9@redhat.com>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 4 Sep 2026 09:35:15 -0700
X-Gm-Features: AcwNN1WNXLSvtyVAFapWkxaJNMynb6TeuCGFIC9gx9Me3t-V-hPVmGWH2aYK2II
Message-ID: <CAMP57yXGDz+AM0C54MZKgYDCunWgZA2drCMaZddA5CGNsueDqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vfio-user: support multiple FDs backing region
 mmaps
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:34::10;
 envelope-from=namangulati@google.com; helo=mail-qk2-x10.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Sep 4, 2026 at 5:38=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> Hi Naman,
>
> Thanks for the series. However, the multiple FDs are a vfio-user
> transport detail. The core VFIO only needs to know "which fd to
> mmap for this subregion" and it doesn't need to manage arrays of
> FDs per region. So, I'd prefer :

Thanks for the review Cedric. That makes sense to me, I'll refactor accordi=
ngly.

>
>   1. No change.
>
>   2. Add 'fd' and 'fd_offset' to VFIOMmap :
>
>       typedef struct VFIOMmap {
>       ...
>      +    int fd;             /* per-mmap fd, or -1 to use the region fd =
*/
>      +    uint64_t fd_offset; /* offset within fd for the mmap call */
>       } VFIOMmap;
>
>      This is the only core VFIO change.
>
>   3. Add a 'setup_sparse_mmaps' hook to VFIODeviceIOOps
>
>   4. vfio-user: support multiple FDs for sparse mmap regions
>      All multi-fd logic stays in hw/vfio-user/device.c
>
> Thanks,
>
> C.
>
>
> On 9/3/26 19:46, Naman Gulati wrote:
> > Gentle ping on this series incase it got lost in the noise :)
> >
> > On Tue, Aug 25, 2026 at 10:00=E2=80=AFPM Naman Gulati <namangulati@goog=
le.com> wrote:
> >>
> >> This series extends the vfio-user protocol specification to allow
> >> servers to pass multiple file descriptors for different sparse memory
> >> areas to be mmap'ed within a single device region.
> >>
> >> This extension is intended for exposing paravirtualized PCI devices vi=
a
> >> a vfio-user server that may have multiple unique sub-regions in a BAR
> >> backed by some mmap'able buffers sourced from distinct file descriptor=
s.
> >>
> >> This change introduces a new capability:
> >>    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> >>
> >> Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
> >> from a single open file descriptor), this new capability defines an
> >> array of sparse mmap areas where each area contains an index into the
> >> array of file descriptors.
> >>
> >> When all sparse areas share a single file descriptor, servers may
> >> continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
> >> file descriptor in SCM_RIGHTS for backwards compatibility with older
> >> clients.
> >>
> >> The extensions in this series also lays the groundwork to make use of
> >> the in-development series [1] extending vfio-pci to return distinct
> >> dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
> >> may choose to return dmabuf FDs for various regions of a device's BAR =
to
> >> map a vfio passthrough device into the guest, in order to retain contr=
ol
> >> of the device and be able to revoke mappings passed to the VM.
> >>
> >> libvfio-user server side changes WIP on github [2].
> >>
> >>
> >> [1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org
> >> [2] https://github.com/NamanGulati/libvfio-user/tree/multi-region-fd
> >>
> >> ---
> >> Changes from RFC:
> >>    - Refactored the get_region_info callback to keep vbasedev constant
> >>      and take in a VFIORegionFDs* out parameter to store the received =
fds.
> >>    - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.40=
1797-1-namangulati@google.com
> >> ---
> >>
> >> Naman Gulati (3):
> >>    vfio-user: add multi-fd region mmap capability
> >>    vfio: mmap sparse regions backed by multiple FDs
> >>    vfio-user: implement client support for multi-fd region mmap
> >>
> >>   docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++++++++++=
--
> >>   hw/vfio-user/device.c         | 66 ++++++++++++++++++++++++++++++--
> >>   hw/vfio-user/protocol.h       | 20 ++++++++++
> >>   hw/vfio/device.c              | 49 ++++++++++++++----------
> >>   hw/vfio/region.c              | 41 ++++++++++++++++----
> >>   hw/vfio/vfio-region.h         |  8 ++++
> >>   include/hw/vfio/vfio-device.h | 32 ++++++++++++++--
> >>   7 files changed, 249 insertions(+), 38 deletions(-)
> >>
> >> --
> >> 2.55.0.860.g4b6b3295ed-goog
> >>
> >
>

