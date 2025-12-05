Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD70D2E00E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 07:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRQ0m-0000fN-5Y; Fri, 05 Dec 2025 02:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRQ0Z-0000bA-F6; Fri, 05 Dec 2025 02:13:42 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vRQ0X-0004iC-AG; Fri, 05 Dec 2025 02:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764918817; x=1796454817;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=w3Buc0Ps7o9i/SjFHREmo0voDOT2uY6Lid8xV3QUcqk=;
 b=StgiC5J4jvnQ9lyiCqztjaoZefBWFs9+rQtTk8fUVLwI0JiNir/TopyR
 xVpt6kI8lCeUaJHL+T6X0Udc1JKq/a5+wDcgyNCt4GhfBhLHnm7KKWLt4
 TSfNU3NhqtrGJZWd4X3GIxRcyNRzQH6lAwPvLuFVu7t5MAs79EIcdBl5T
 MPWs5Ukf0TY4ldVkK8kuIEggM7yAbhfmQibXzg+Y4FR+104JT5bWq+3CF
 xuneUdz0xRhLrSwUmB8oKvS/Sludb0ltWqcHofv07TSu6A8DXSpa6yKWW
 VRXWpjNbmPaQUc7Gf5iBJhmx9Ihk8KUYhhOeJE8nu6vnYYJl9i9YjE/vl A==;
X-CSE-ConnectionGUID: 7Jvu16G2S3+c1EXfljocew==
X-CSE-MsgGUID: cCO1Yh+ZTfuaWZRgr+rWGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="70569583"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="70569583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 23:13:34 -0800
X-CSE-ConnectionGUID: qwVBAMkDSra50/dDv7oETg==
X-CSE-MsgGUID: rmkcl3IJQT6WBXcUfk/7+g==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2025 23:13:32 -0800
Date: Fri, 5 Dec 2025 15:38:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 04/14] rust: add Serialize implementation for QObject
Message-ID: <aTKL6FaZ9bNfWETG@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001080051.1043944-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Wed, Oct 01, 2025 at 10:00:41AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:41 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/14] rust: add Serialize implementation for QObject
> X-Mailer: git-send-email 2.51.0
> 
> This allows QObject to be converted to other formats, for example
> JSON via serde_json.
> 
> This is not too useful, since QObjects are consumed by
> C code or deserialized into structs, but it can be used for testing
> and it is part of the full implementation of a serde format.
> 
> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock                    |  1 +
>  rust/util/Cargo.toml               |  1 +
>  rust/util/meson.build              |  3 +-
>  rust/util/src/qobject/mod.rs       |  4 +-
>  rust/util/src/qobject/serialize.rs | 59 ++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 3 deletions(-)
>  create mode 100644 rust/util/src/qobject/serialize.rs

...

> +impl Serialize for QObject {
> +    #[inline]
> +    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
> +    where
> +        S: ::serde::Serializer,
> +    {
> +        match_qobject! { (self) =>
> +            () => serializer.serialize_unit(),
> +            bool(b) => serializer.serialize_bool(b),
> +            i64(i) => serializer.serialize_i64(i),
> +            u64(u) => serializer.serialize_u64(u),
> +            f64(f) => serializer.serialize_f64(f),
> +            CStr(cstr) => cstr.to_str().map_or_else(
> +                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),
> +                |s| serializer.serialize_str(s),
> +            ),
> +            QList(l) => {
> +                let mut node_ptr = unsafe { l.head.tqh_first };
> +                let mut state = serializer.serialize_seq(None)?;
> +                while !node_ptr.is_null() {
> +                    let node = unsafe { &*node_ptr };
> +                    let elem = unsafe { ManuallyDrop::new(QObject::from_raw(addr_of!(*node.value))) };
> +                    state.serialize_element(&*elem)?;

QObject here is always valid so it's not necessary to concern about it
is destroied by C side, and so that it's not necessary to use
cloned_from_raw here.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


